package br.poli.ecomp.geav.nhe.model.server
{
	import appkit.responders.NResponder;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.XMLSocket;
	import flash.system.Security;

	public class ServerConnection
	{
		public static const SERVER_CONNECTED:String = "SERVER_CONNECTED";
		public static const SERVER_IO_ERROR:String = "SERVER_IO_ERROR";
		public static const SERVER_RECEIVED:String = "SERVER_RECEIVED";
		public static const SERVER_CLOSED:String = "SERVER_CLOSED";
		
		private var socket:XMLSocket;
		private var port:Number;
		private var address:String;
		private var _prl_requests:Vector.<ServerRequest>;
		private var _prl_responses:Vector.<ServerResponse>;
		
		/*------------------------------------
		* 		   PUBLIC METHODS
		-----------------------------------*/
		public function ServerConnection(address:String)
		{
			this.port = port;
			this.address = address;
			this._prl_requests = new Vector.<ServerRequest>();
			this._prl_responses = new Vector.<ServerResponse>();
		}
		
		public function get prl_responses():Vector.<ServerResponse>
		{
			return _prl_responses;
		}

		public function get prl_requests():Vector.<ServerRequest>
		{
			return _prl_requests;
		}

		public function setup():void
		{
			Security.allowDomain("*");
			Security.loadPolicyFile(this.address);
			socket = new XMLSocket();
			NResponder.addNative(socket, Event.CONNECT, socket_connect_event);
			NResponder.addNative(socket, IOErrorEvent.IO_ERROR, socket_ioerror_event);
			NResponder.addNative(socket, DataEvent.DATA, socket_data_event);
			NResponder.addNative(socket, Event.CLOSE, socket_close_event);
			_prl_requests = new Vector.<ServerRequest>();
			_prl_responses = new Vector.<ServerResponse>();
		}
		
		public function connect():void
		{
			socket.connect(address,port);
		}
		
		public function send(request:ServerRequest):void
		{
			socket.send(request.text + "\r");
		}
		
		public function sendMulti(requests:Vector.<ServerRequest>):void
		{
			socket.send(requests.join(ServerDefaults.SEPARATOR_REQUESTS)+"\r");
		}
		
		public function disconnect():void
		{
			socket.close();
		}
		
		/*------------------------------------
		* 		   	 PROPERTIES
		-----------------------------------*/
		public function get connected():Boolean
		{
			return socket.connected;
		}
		
		/*------------------------------------
		* 		   PRIVATE METHODS
		-----------------------------------*/
		private function socket_ioerror_event(e:IOErrorEvent):void
		{
			NResponder.dispatch(SERVER_IO_ERROR);
		}
		
		private function socket_connect_event(e:Event):void
		{
			NResponder.dispatch(SERVER_CONNECTED);
		}
		
		private function socket_data_event(e:DataEvent):void
		{
			append_responses(e.data);
			NResponder.dispatch(SERVER_RECEIVED);
		}
		
		private function socket_close_event(e:Event):void
		{
			NResponder.dispatch(SERVER_CLOSED);
		}
		
		private function append_responses(data:String):void
		{
			var responses:Array = data.split(ServerDefaults.SEPARATOR_REQUESTS);
			for(var i:uint = 0; i < responses.length; i++)
			{
				prl_requests.push(new ServerResponse(responses[i]));
			}
		}
	}
}