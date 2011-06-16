package view.util
{
	import ru.inspirit.asfeat.detect.ASFEATDetectType;
	import ru.inspirit.asfeat.detect.ASFEATReference;
	import ru.inspirit.asfeat.event.ASFEATCalibrationEvent;
	import apparat.memory.Memory;
	
	import arsupport.ARAway3DLiteContainer;
	import arsupport.demo.away3dlite.World3D;
	
	import net.hires.debug.Stats;
	
	import ru.inspirit.asfeat.ASFEAT;
	import ru.inspirit.asfeat.calibration.IntrinsicParameters;
	import ru.inspirit.asfeat.event.ASFEATDetectionEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * @author Eugene Zatepyakin
	 */
	[SWF(width='640',height='600',frameRate='25',backgroundColor='0xFFFFFF')]
	public final class TestASFEAT extends Sprite
	{
		// embed your data file here
		[Embed(source = '../assets/def_img_data.ass', mimeType='application/octet-stream')]
		private static const graff_data_ass:Class;
		
		// init asfeat instance and support classes
		public var asfeat:ASFEAT = new ASFEAT();
		public var intrinsic:IntrinsicParameters;
		public var world3d:World3D;
		
		// max transfromation error to accept
		public var maxTransformError:Number = 10 * 10;
		
		// forget it
		public var ram:ByteArray;		
		
		// different visual objects
		protected var myview:Sprite;
		public static var _txt:TextField;
		protected var camBmp:Bitmap;
		protected var _cam:Camera;
		protected var _video:Video;
		protected var _cambuff:BitmapData;
		protected var _buffer:BitmapData;
		protected var _cambuff_rect:Rectangle;
		protected var _cam_mtx:Matrix;
		protected var _buff_rect:Rectangle;
		protected var _buff_mtx:Matrix;
		
		// models array if u need it
		public var models:Vector.<ARAway3DLiteContainer>;
		
		// camera size
		public var camWidth:int = 640;
		public var camHeight:int = 480;
		public var downScaleRatio:Number = 1; // better leave it as it is
		public var srcWidth:int = 640; // should be the same as camera size untill downscale is used
		public var srcHeight:int = 480;
		public var maxPointsToDetect:int = 300; // max point to allow on the screen
		public var maxReferenceObjects:int = 6; // max reference objects to be used
		public var mirror:Boolean = true; // mirror camera output
		
		public var stat:Stats;
		
		public function Main()
		{
			if(stage) onAddedToStage();
			else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event = null):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			asfeat.addEventListener( Event.INIT, init ); // wait before this event fired or it wont work
		}
		
		protected function init(e:Event = null):void
		{
			asfeat.removeEventListener( Event.INIT, init );
			initStage();
			//
			myview = new Sprite();
			
			// debug test field
			_txt = new TextField();
			_txt.autoSize = 'left';
			_txt.width = 300;
			_txt.x = 5;
			_txt.y = 480;                   
			myview.addChild(_txt);
			//
			srcWidth = camWidth * downScaleRatio;
			srcHeight = camHeight * downScaleRatio;
			
			// web camera initiation
			initCamera(camWidth, camHeight, 25);
			camBmp = new Bitmap(_cambuff.clone());
			myview.addChild(camBmp);
			//
			
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
			
			// init our engine
			asfeat.lib.init( ram, 0, srcWidth, srcHeight, maxPointsToDetect, maxReferenceObjects, maxTransformError, stage );
			
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
			stat = new Stats();
			myview.addChild( stat );
			stat.x = 640 /*- 87 */- 80;
			stat.y = 490;
			
			addChild(myview);
			
			// init 3d world object
			init3d();
			
			// start dection + 3d render
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		protected function render(e:Event = null):void
		{	
			// draw video stream to buffer
			_cambuff.draw( _video );
			
			// update out screen camera bitmap
			if(mirror)
			{
				camBmp.bitmapData.draw( _cambuff, _cam_mtx );
			} else {
				camBmp.bitmapData.draw( _cambuff );
			}
			
			// call it each frame so if lost will accur
			// more then 8 frames with no detected/tracked event
			// it will be erased from the screen
			models[0].lost();
			_txt.text = '';
			
			// update detection buffer & run detection
			_buffer.draw( _cambuff, _buff_mtx, null, null, null, true );
			asfeat.lib.detect( _buffer );
			
			// render 3d world models
			world3d.render();
		}
		
		protected function onModelDetected(e:ASFEATDetectionEvent):void
		{
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
			
			_txt.appendText( '\ncalib fx/fy: ' + [intrinsic.fx, intrinsic.fy] );
		}
		
		protected function onCalibDone(e:ASFEATCalibrationEvent):void
		{
			var fx:Number = (e.fx + e.fy) * 0.5;
			var fy:Number = fx;
			
			intrinsic.update(fx, fy, intrinsic.cx, intrinsic.cy);
			
			asfeat.lib.updateIntrinsicParams();
			world3d.updateAROptions();
			
			_txt.appendText( '\ncalib fx/fy: ' + [intrinsic.fx, intrinsic.fy] );
		}
		
		protected function init3d():void
		{
			intrinsic = asfeat.lib.getIntrinsicParams();
			world3d = new World3D( intrinsic, camWidth, camHeight );
			
			world3d.initIn2ArLogo();
			
			models = Vector.<ARAway3DLiteContainer>([
				world3d.in2ar/*, 
				world3d.airplane, 
				world3d.mario_char, 
				world3d.ferrari*/
			]);
			
			addChild(world3d);
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
			_cam.setMode( w, h, fps, true );
			
			_video = new Video( _cam.width, _cam.height );
			_video.attachCamera( _cam );
		}
		
		protected function initStage():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			
			var myContextMenu:ContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			
			var copyr:ContextMenuItem;
			copyr = new ContextMenuItem("ASFEAT/IN2AR DEMO", true, false);
			myContextMenu.customItems.push(copyr);
			copyr = new ContextMenuItem("© inspirit.ru", false, false);
			myContextMenu.customItems.push(copyr);
			
			contextMenu = myContextMenu;
		}
	}
}
