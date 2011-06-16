package controller.action
{
	import appkit.responders.NResponder;
	
	import controller.augmentedreality.ARController;
	import controller.db.DBController;
	import controller.server.ServerController;
	
	import flash.events.Event;
	
	import model.server.ServerConnection;
	import model.server.ServerDefaults;
	import model.server.ServerRequest;
	import model.server.ServerResponse;
	
	import ru.inspirit.asfeat.event.ASFEATDetectionEvent;

	public class ActionController
	{
		private var pro_db_controller:DBController;
		private var pro_server_controller:ServerController;
		private var pro_ar_controller:ARController;
		
		public function ActionController(db_controller:DBController, server_controller:ServerController, ar_controller:ARController)
		{
			this.pro_ar_controller = ar_controller;
			this.pro_db_controller = db_controller;
			this.pro_server_controller = server_controller;
		}
		
		public function setup():void
		{
			NResponder.add(ServerConnection.SERVER_CLOSED, server_closed_event);
			NResponder.add(ServerConnection.SERVER_CONNECTED, server_connected_event);
			NResponder.add(ServerConnection.SERVER_IO_ERROR, server_io_error_event);
			NResponder.add(ServerConnection.SERVER_RECEIVED, server_received_event);
			
			NResponder.add(ARController.DETECTED, arcontroller_detected_event);
		}
		
		private function server_closed_event():void
		{
			
		}
		
		private function server_connected_event():void
		{
			
		}
		
		private function server_io_error_event():void
		{
			
		}
		
		private function server_received_event():void
		{
			while(pro_server_controller.hasResponse)
			{
				var response:ServerResponse = pro_server_controller.nextResponse();
				switch(response.prn_function_id)
				{
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
					case ServerDefaults.RESPONSE_CHAT_RECEIVED:
						break;
				}
			}
		}
		private function arcontroller_detected_event(e:ASFEATDetectionEvent):void
		{
		}
	}
}