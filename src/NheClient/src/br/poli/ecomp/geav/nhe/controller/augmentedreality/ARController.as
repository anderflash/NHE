package br.poli.ecomp.geav.nhe.controller.augmentedreality
{
	import apparat.memory.Memory;
	
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.controller.IController;
	import br.poli.ecomp.geav.nhe.controller.world.WorldController;
	import br.poli.ecomp.geav.nhe.view.augmentedreality.ARDetector;
	import br.poli.ecomp.geav.nhe.view.augmentedreality.ARView;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import ru.inspirit.asfeat.ASFEAT;
	import ru.inspirit.asfeat.event.ASFEATCalibrationEvent;
	import ru.inspirit.asfeat.event.ASFEATDetectionEvent;
	
	public class ARController implements IController
	{
		private var _pro_world_controller:WorldController;
		private var pre_event:ASFEATDetectionEvent;
		
		private var prl_pen_translation_matrix:Vector.<Number>;
		private var prl_pen_rotation_matrix:Vector.<Number>;
		
		public static const DETECTED:String = "DETECTED";
		
		public static const STARTED:String = "AR_STARTED";
		
		private var stage:Stage;
		
		private var _asfeat:ASFEAT;
		
		// max transfromation error to accept
		public var maxTransformError:Number = 10 * 10;
		
		// different visual objects
		protected var camBmp:Bitmap;
		protected var _cam:Camera;
		protected var _video:Video;
		protected var _cambuff:BitmapData;
		protected var _buffer:BitmapData;
		protected var _cambuff_rect:Rectangle;
		protected var _cam_mtx:Matrix;
		protected var _buff_rect:Rectangle;
		protected var _buff_mtx:Matrix;
		
		// forget it
		public var ram:ByteArray;
		
		// camera size
		public var camWidth:int = 640;
		public var camHeight:int = 480;
		public var downScaleRatio:Number = 1; // better leave it as it is
		public var srcWidth:int = 640; // should be the same as camera size untill downscale is used
		public var srcHeight:int = 480;
		public var maxPointsToDetect:int = 300; // max point to allow on the screen
		public var maxReferenceObjects:int = 6; // max reference objects to be used
		public var mirror:Boolean = true; // mirror camera output
		
		// embed your data file here
		[Embed(source = '../assets/def_img_data.ass', mimeType='application/octet-stream')]
		private static const graff_data_ass:Class;
		
		public function ARController(world_controller:WorldController, stage:Stage)
		{
			this.stage = stage;
			
			_asfeat = new ASFEAT();
			asfeat.addEventListener( Event.INIT, init ); // wait before this event fired or it wont work
			
			_pro_world_controller = world_controller;
		}
		
		public function setup():void
		{
			asfeat.addEventListener( Event.INIT, init ); // wait before this event fired or it wont work
			//NResponder.addNative(this, ASFEATDetectionEvent.DETECTED, ardetector_detected_event);
		}
		

		public function get asfeat():ASFEAT
		{
			return _asfeat;
		}
		
		protected function init(e:Event = null):void
		{
			asfeat.removeEventListener( Event.INIT, init );
			
			srcWidth = camWidth * downScaleRatio;
			srcHeight = camHeight * downScaleRatio;
			
			// web camera initiation
			initCamera(camWidth, camHeight, 25);
			
			
			_cambuff_rect = _cambuff.rect;
			_cam_mtx = new Matrix(-1.0, 0, 0, 1.0, camWidth);
			
			_buffer = new BitmapData( srcWidth, srcHeight, false, 0x00 );
			_buff_rect = _buffer.rect;
			_buff_mtx = new Matrix(downScaleRatio, 0, 0, downScaleRatio);
			//
			
			// just believe me
			ram = new ByteArray();
			ram.endian = Endian.LITTLE_ENDIAN;
			ram.length = asfeat.lib.calcRequiredChunkSize(srcWidth, srcHeight, maxPointsToDetect, maxReferenceObjects);
			ram.position = 0;
			Memory.select(ram);
			
			var pode:Boolean = false;
			stage.addEventListener(Event.ENTER_FRAME, stage_enter_frame);
		}
		private function stage_enter_frame(e:Event):void
		{
			try
			{
				// init our engine
				asfeat.lib.init( ram, 0, srcWidth, srcHeight, maxPointsToDetect, maxReferenceObjects, maxTransformError, stage );
				
				stage.removeEventListener(Event.ENTER_FRAME, stage_enter_frame);
				
				// add reference object
				asfeat.lib.addReferenceObject( ByteArray( new graff_data_ass ) );
				
				// add event listeners
				asfeat.lib.addListener( ASFEATDetectionEvent.DETECTED, onModelDetected );
				asfeat.lib.addListener( ASFEATCalibrationEvent.COMPLETE, onCalibDone );
				
				// ATTENTION 
				// use it if u want only one model to be detected
				// and available at single frame (better performace)
				asfeat.lib.setSingleReferenceMode(true);
				
				// u can repform geometric calibration
				// during detection/tracking (see onCalibDone method)
				//asfeat.lib.startGeometricCalibration();
				
				// add statistic
				
				
				for(var i:uint =0; i < stage.numChildren; i++)
				{
					var sprite:Sprite = stage.getChildAt(i) as Sprite;
					if(sprite.height == 100)
					{
						sprite.alpha = 0;
						sprite.mouseEnabled = false;
						sprite.mouseChildren = false;
						//stage.removeChild(sprite);
						sprite.graphics.clear();
						sprite.removeChildren();
						break;
					}
				}
				NResponder.dispatch(STARTED);
			}
			catch(e:Error)
			{
				trace(e.getStackTrace());
			}
			
		}
		
		protected function initCamera(w:int = 640, h:int = 480, fps:int = 25):void
		{
			var camName:String = null;
			if(Capabilities.os.toLowerCase().indexOf('mac os') == 0)
			{
				var camNames:Array = Camera.names;
				for (var i:int = 0; i < camNames.length; ++i)
				{
					if (String( camNames[i] ).toLowerCase().indexOf( 'usb' ) > -1)
					{
						camName = i.toString();
						break;
					}
				}
			}
			_cambuff = new BitmapData( w, h, false, 0x0 );
			_cam = Camera.getCamera(camName);
			if(_cam)
				_cam.setMode( w, h, fps, true );
		}
		protected function onModelDetected(e:ASFEATDetectionEvent):void
		{/*
			var refList:Vector.<ASFEATReference> = e.detectedReferences;
			var ref:ASFEATReference;
			var n:int = refList.length;
			var state:String;
			
			for(var i:int = 0; i < n; ++i)
			{
				ref = refList[i];
				state = ref.detectType;
				if (ref.poseError < maxTransformError || state == ASFEATDetectType.PREDICTED)
				{
					models[0].setTransform( ref.rotationMatrix, ref.translationVector, ref.poseError, mirror );
					_txt.text = state;
					if(state == '_detect')
					{
						_txt.appendText( '\nmathed: ' + (ref.screenCoords.length >> 1) );
					}
					_txt.appendText( '\nfound id: ' + ref.id );
				}
			}
			
			_txt.appendText( '\ncalib fx/fy: ' + [intrinsic.fx, intrinsic.fy] );*/
		}
		
		protected function onCalibDone(e:ASFEATCalibrationEvent):void
		{
			/*var fx:Number = (e.fx + e.fy) * 0.5;
			var fy:Number = fx;
			
			intrinsic.update(fx, fy, intrinsic.cx, intrinsic.cy);
			
			asfeat.lib.updateIntrinsicParams();
			world3d.updateAROptions();
			
			_txt.appendText( '\ncalib fx/fy: ' + [intrinsic.fx, intrinsic.fy] );*/
		}
		/*private function ardetector_detected_event(e:ASFEATDetectionEvent):void
		{
			this.pre_event = e;
			NResponder.dispatch(DETECTED,[e]);
		}*/
	}
}