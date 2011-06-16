package controller.server
{
	import appkit.responders.NResponder;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.Socket;
	import flash.net.sendToURL;
	
	import model.server.ServerConnection;
	import model.server.ServerDefaults;
	import model.server.ServerRequest;
	import model.server.ServerResponse;

	public class ServerController
	{
		private var _prn_server_connection:ServerConnection;
		
		private static var _instance:ServerController = new ServerController();
		
		public function ServerController()
		{
			if(_instance) throw new Error("Singleton on ServerController");
		}
		
		public static function get instance():ServerController
		{
			return _instance;
		}
		
		public function setup():void
		{
			_prn_server_connection = new ServerConnection(ServerDefaults.HOST, ServerDefaults.PORT);
		}
		
		public function get prn_server_connection():ServerConnection
		{
			return _prn_server_connection;
		}

		public function connect():void
		{
			
			_prn_server_connection.connect();
		}
		
		public function disconnect():void
		{
			_prn_server_connection.disconnect();
		}
		
		public function request_send(request:ServerRequest):void
		{
			prn_server_connection.send(request);
		}
		
		public function get hasResponse():Boolean
		{
			return prn_server_connection.prl_responses.length > 0;
		}
		
		public function nextResponse(removing:Boolean = true):ServerResponse
		{
			if(removing) 
				return prn_server_connection.prl_responses.shift();
			else
				return prn_server_connection.prl_responses[0];
		}
		
		public function process_requests():void
		{
			prn_server_connection.sendMulti(prn_server_connection.prl_requests);
		}
	}
}