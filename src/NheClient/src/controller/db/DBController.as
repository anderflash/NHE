package controller.db
{
	import controller.IController;
	import controller.server.ServerController;
	
	import marcozero.marzsdk.net.db.MZDatabase;
	
	import model.db.Database;
	import model.server.ServerConnection;
	
	public class DBController implements IController
	{
		private var pro_server_controller:ServerController;
		private var pro_database:Database;
		
		public function DBController(server_controller:ServerController)
		{
			this.pro_server_controller = server_controller;
		}
		
		public function setup():void
		{
			pro_server_controller = ServerController.instance;
			pro_database = Database.instance;
		}
	}
}