package controller
{
	import controller.action.ActionController;
	import controller.augmentedreality.ARController;
	import controller.db.DBController;
	import controller.server.ServerController;
	import controller.world.WorldController;
	
	import flash.display.Stage;
	
	import view.NHEView;

	public class NHEController
	{
		private var stage:Stage;
		private var _pro_nhe_view:NHEView;
		
		public static const CREATION_COMPLETE:String = "CREATION_COMPLETE";
		
		// Controllers
		private var pro_server_controller:ServerController;
		private var pro_world_controller:WorldController;
		private var pro_db_controller:DBController;
		private var pro_action_controller:ActionController;
		private var pro_ar_controller:ARController;
		
		/*------------------------------------
		* 			PUBLIC METHODS
		-----------------------------------*/
		public function NHEController(stage:Stage)
		{
			this.stage = stage;
		}
		
		public function setup():void
		{
			create_controllers();
			
		}
		
		public function start():void
		{
			
		}
		
		/*------------------------------------
		* 			  PROPERTIES
		-----------------------------------*/
		public function get pro_nhe_view():NHEView
		{
			return _pro_nhe_view;
		}
		
		/*------------------------------------
		* 		   PRIVATE METHODS
		-----------------------------------*/
		private function create_controllers():void
		{
			pro_server_controller = new ServerController();
			pro_db_controller = new DBController(pro_server_controller);
			pro_ar_controller = new ARController(stage);
			pro_action_controller = new ActionController(pro_db_controller, pro_server_controller, pro_ar_controller);
			pro_world_controller = new WorldController(stage);
		}
	}
}