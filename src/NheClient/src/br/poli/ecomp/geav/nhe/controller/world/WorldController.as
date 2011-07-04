package br.poli.ecomp.geav.nhe.controller.world
{
	import br.poli.ecomp.geav.nhe.view.world.WorldView;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import ru.inspirit.asfeat.calibration.IntrinsicParameters;

	public class WorldController
	{
		private var _prn_world_view:WorldView;
		private var stage:Stage;
		
		public function WorldController(stage:Stage)
		{
			this.stage = stage;
		}
		
		public function create_world(intrinsic:IntrinsicParameters):void
		{
			this._prn_world_view = new WorldView();
			this._prn_world_view.setup(intrinsic);
		}
		
		
		public function get prn_world_view():WorldView
		{
			return _prn_world_view;
		}
		
		public function setup(intrinsic:IntrinsicParameters):void
		{
			create_world(intrinsic);
			prn_world_view.view_show(WorldView.VIEW_MINE);
			prn_world_view.view_show(WorldView.VIEW_OWNER);
		}
	}
}