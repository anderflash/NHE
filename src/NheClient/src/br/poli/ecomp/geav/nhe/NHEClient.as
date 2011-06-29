package br.poli.ecomp.geav.nhe
{
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.controller.NHEController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class NHEClient extends Sprite
	{
		private var prn_nhe_controller:NHEController;
		
		public function NHEClient()
		{
			if(stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			NResponder.add(NHEController.CREATION_COMPLETE, nhecontroller_creation_complete_event);
			prn_nhe_controller = new NHEController(this.stage);
			prn_nhe_controller.setup();
		}
		
		private function nhecontroller_creation_complete_event():void
		{
			prn_nhe_controller.start();
		}
	}
}