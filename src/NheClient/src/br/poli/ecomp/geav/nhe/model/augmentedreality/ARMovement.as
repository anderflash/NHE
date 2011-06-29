package br.poli.ecomp.geav.nhe.model.augmentedreality
{
	import br.poli.ecomp.geav.nhe.controller.action.IMovement;
	
	import ru.inspirit.asfeat.event.ASFEATDetectionEvent;
	
	public class ARMovement implements IMovement
	{
		public static const MOVING:Number = 1;
		public static const TOUCHING:Number = 2;
		
		private var _movement:Number;
		
		private var prn_detection_event:ASFEATDetectionEvent;
		
		public function ARMovement(movement:Number)
		{
			this.movement = movement;
		}

		public function get movement():Number
		{
			return _movement;
		}
	}
}