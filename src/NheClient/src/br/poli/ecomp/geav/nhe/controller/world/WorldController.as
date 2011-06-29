package br.poli.ecomp.geav.nhe.controller.world
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import br.poli.ecomp.geav.nhe.view.world.WorldView;

	public class WorldController
	{
		private var _prn_world_view:WorldView;
		private var stage:Stage;
		
		public function WorldController(stage:Stage)
		{
			this.stage = stage;
		}
		
		public function create_world():void
		{
			this._prn_world_view = new WorldView();
		}
		
		
		public function get prn_world_view():Sprite
		{
			return _prn_world_view;
		}
		
		public function setup():void
		{
			create_world();
		}
	}
}