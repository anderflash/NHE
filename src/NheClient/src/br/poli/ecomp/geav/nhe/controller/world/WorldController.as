package br.poli.ecomp.geav.nhe.controller.world
{
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.view.world.WorldView;
	
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
		
		/**
		 * Add a Block 
		 * 
		 */
		public function block_add():void
		{
			
		}
		
		/**
		 * Remove a Block 
		 * 
		 */
		public function block_remove():void
		{
			
		}
		
		/**
		 * Move a Block 
		 * 
		 */
		public function block_move():void
		{
			
		}
		
		/**
		 * Connect two blocks 
		 * 
		 */
		public function blocks_connect():void
		{
			
		}
		
		/**
		 * Create Menu 
		 * 
		 */
		public function menu_create():void
		{
			
		}
		
		/**
		 * Put the transforming matrices to the scene 
		 * 
		 */		
		public function scene_transform():void
		{
			
		}
		
		/**
		 * Get the WorldView
		 * @return 
		 * 
		 */
		public function get prn_world_view():WorldView
		{
			return _prn_world_view;
		}
		
		/**
		 * Setup the World 
		 * @param intrinsic
		 * 
		 */
		public function setup(intrinsic:IntrinsicParameters):void
		{
			create_world(intrinsic);
			prn_world_view.view_show(WorldView.VIEW_MINE);
			prn_world_view.view_show(WorldView.VIEW_OWNER);
		}
		
		/**
		 * Undo Action 
		 * @param action
		 * 
		 */
		public function action_undo(action:Action):void
		{
			
		}
		
		/**
		 * Do the Action 
		 * @param action
		 * 
		 */
		public function action_do(action:Action):void
		{
			
		}
	}
}