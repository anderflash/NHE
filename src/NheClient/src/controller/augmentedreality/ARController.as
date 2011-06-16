package controller.augmentedreality
{
	import appkit.responders.NResponder;
	
	import controller.IController;
	
	import flash.display.Stage;
	
	import ru.inspirit.asfeat.event.ASFEATDetectionEvent;
	
	import view.augmentedreality.ARDetector;
	import view.augmentedreality.ARView;
	
	public class ARController implements IController
	{
		private var pro_ar_detector:ARDetector;
		private var pro_ar_view:ARView;
		private var pre_event:ASFEATDetectionEvent;
		
		private var prl_pen_translation_matrix:Vector.<Number>;
		private var prl_pen_rotation_matrix:Vector.<Number>;
		
		public static const DETECTED:String = "DETECTED";
		
		private var stage:Stage;
		
		public function ARController(stage:Stage)
		{
			this.stage = stage;
		}
		
		public function setup():void
		{
			NResponder.addNative(pro_ar_detector, ASFEATDetectionEvent.DETECTED, ardetector_detected_event);
		}
		
		private function ardetector_detected_event(e:ASFEATDetectionEvent):void
		{
			this.pre_event = e;
			NResponder.dispatch(DETECTED,[e]);
		}
	}
}