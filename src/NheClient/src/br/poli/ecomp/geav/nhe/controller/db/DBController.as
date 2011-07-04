package br.poli.ecomp.geav.nhe.controller.db
{
	import br.poli.ecomp.geav.nhe.controller.IController;
	import br.poli.ecomp.geav.nhe.controller.server.ServerController;
	import br.poli.ecomp.geav.nhe.model.db.Database;
	import br.poli.ecomp.geav.nhe.model.server.ServerConnection;
	
	import marcozero.marzsdk.net.db.MZDatabase;
	
	public class DBController implements IController
	{
		private var pro_server_controller:ServerController;
		private var pro_database:Database;
		
		private static var _instance:DBController = new DBController();
		
		public function DBController()
		{
		}
		
		public function setup():void
		{
			pro_server_controller = ServerController.instance;
			pro_database = Database.instance;
		}
		
		public static function get instance():DBController
		{
			return _instance;
		}
	}
}