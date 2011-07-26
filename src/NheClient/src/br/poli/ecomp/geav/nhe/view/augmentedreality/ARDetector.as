package br.poli.ecomp.geav.nhe.view.augmentedreality
{
<<<<<<< HEAD
	import appkit.responders.NResponder;
	
	import flash.display.Stage;
	import flash.events.Event;
	
	import ru.inspirit.asfeat.ASFEAT;

=======
	import appkit.responders.NResponder;
	
	import flash.display.Stage;
	import flash.events.Event;
	
	import ru.inspirit.asfeat.ASFEAT;

>>>>>>> cd6d26b2dcc6e982fdf89a2d86f833a167a182d8
	public class ARDetector
	{
		private var _pao_ar_view:ARView;
		private var asfeat:ASFEAT;
		private var stage:Stage;
		
		public static const MOVEMENT_DETECTED:String = "MOVEMENT_DETECTED";
		
		public function ARDetector(stage:Stage, ar_view:ARView)
		{
			asfeat = new ASFEAT();
			
			this.stage = stage;
			this._pao_ar_view = ar_view;
			
		}
		
		protected function init(e:Event = null):void
		{
		/*	asfeat.removeEventListener( Event.INIT, init );
			
			myview = new Sprite();
			
			srcWidth = camWidth * downScaleRatio;
			srcHeight = camHeight * downScaleRatio;
			
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
			stat.x = 640 - 80; //640 - 87
			stat.y = 490;
			
			addChild(myview);
			
			// init 3d world object
			init3d();
			
			// start dection + 3d render
			addEventListener(Event.ENTER_FRAME, render);*/
		}
		
		public function detection_start():void
		{
			NResponder.addNative(this._pao_ar_view, Event.ENTER_FRAME, ar_view_enter_frame_event);
		}
		
		
		
		public function detection_stop():void
		{
			NResponder.remove(Event.ENTER_FRAME, ar_view_enter_frame_event);
		}
		
		private function ar_view_enter_frame_event(e:Event):void
		{
			detect();
		}
		
		private function detect():void
		{
			
		}
		
		
		protected function render(e:Event = null):void
		{	
			/*// draw video stream to buffer
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
			world3d.render();*/
		}

		public function get pao_ar_view():ARView
		{
			return _pao_ar_view;
		}

		public function set pao_ar_view(value:ARView):void
		{
			_pao_ar_view = value;
		}

	}
}