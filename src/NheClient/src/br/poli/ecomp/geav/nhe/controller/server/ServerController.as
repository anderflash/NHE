package br.poli.ecomp.geav.nhe.controller.server
{
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.model.db.usr.User;
	import br.poli.ecomp.geav.nhe.model.server.LoginStatus;
	import br.poli.ecomp.geav.nhe.model.server.ProcedureResponse;
	import br.poli.ecomp.geav.nhe.model.server.ServerDefaults;
	import br.poli.ecomp.geav.nhe.model.server.ServerResponse;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	import flash.net.NetStream;
	import flash.net.Responder;
	import flash.net.URLRequest;
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;

	public class ServerController
	{
		// Responders name
		private static const LOGIN_RESPONDER:Number = 0;
		private static const CREATE_PROJECT_RESPONDER:Number = 1;
		
		// Events
		public static const MODEL_UPLOADED:String = "MODEL_UPLOADED";
		public static const MODEL_NOT_UPLOADED:String = "MODEL_NOT_UPLOADED";
		public static const LOGIN_STATUS:String = "LOGIN_STATUS";
		public static const CONNECTION_STATUS:String = "CONNECTION_STATUS";
		
		// Singleton
		private static var _instance:ServerController = new ServerController();
		
		private var pro_red5_connection:NetConnection;
		private var pro_cumulus_connection:NetConnection;
		private var pro_net_group:NetGroup;
		private var pro_send_stream:NetStream;
		private var pro_receive_stream:NetStream;
		
		private var pas_host:String;
		
		private var _prb_connected:Boolean;
		private var _prb_logged:Boolean;
		
		private var _pro_logged_user:User;
		
		private var pnl_red5_responders:Vector.<Responder>;
		
		public function ServerController()
		{
			if(_instance) throw new Error("Singleton on ServerController");
		}
		
		public static function get instance():ServerController
		{
			return _instance;
		}
		
		public function uploadFile(fileReference:FileReference):void
		{
			if(!NResponder.has(DataEvent.UPLOAD_COMPLETE_DATA))
			{
				NResponder.addNative(fileReference, DataEvent.UPLOAD_COMPLETE_DATA, filereference_upload_complete_event);
				NResponder.addNative(fileReference, Event.CANCEL, filereference_cancel_event);
				NResponder.addNative(fileReference, Event.COMPLETE, filereference_complete_event);
				NResponder.addNative(fileReference, Event.OPEN, filereference_open_event);
				NResponder.addNative(fileReference, HTTPStatusEvent.HTTP_RESPONSE_STATUS, filereference_response_event);
				NResponder.addNative(fileReference, IOErrorEvent.IO_ERROR, filereference_io_error_event);
				NResponder.addNative(fileReference, ProgressEvent.PROGRESS, filereference_progress_event);
				NResponder.addNative(fileReference, SecurityErrorEvent.SECURITY_ERROR, filereference_security_error_event);
			}
			fileReference.upload(new URLRequest("http://" + 
												 this.pas_host + ":" + ServerDefaults.RED5_HTTP_PORT + "/" + 
												 ServerDefaults.RED5_APPLICATION + "/" + 
												 ServerDefaults.FILE_UPLOAD_SERVLET)); 
		}
		private function filereference_upload_complete_event(e:DataEvent):void
		{
			
		}
		private function filereference_cancel_event(e:Event):void
		{
			
		}
		private function filereference_complete_event(e:Event):void
		{
			
		}
		private function filereference_open_event(e:Event):void
		{
			
		}
		private function filereference_response_event(e:HTTPStatusEvent):void
		{
			
		}
		private function filereference_io_error_event(e:IOErrorEvent):void
		{
			
		}
		private function filereference_progress_event(e:ProgressEvent):void
		{
			
		}
		private function filereference_security_error_event(e:SecurityErrorEvent):void
		{
			
		}
		
		public function createProject(title:String, description:String, model:String, participants:Array):void
		{
			pro_red5_connection.call(ServerDefaults.FUNCTION_CREATE_PROJECT, pnl_red5_responders[CREATE_PROJECT_RESPONDER], title, description, model, participants, this._pro_logged_user.usr_login);
		}
		
		public function setup(host:String):void
		{
			this.pas_host = host;
			pro_red5_connection = new NetConnection();
			pro_cumulus_connection = new NetConnection();
			
			pnl_red5_responders = new Vector.<Responder>();
			
			pnl_red5_responders.push(new Responder(login_responder_result_handler, login_responder_status_handler));
			pnl_red5_responders.push(new Responder(create_project_responder_result_handler, create_project_responder_result_handler));
			
			registerClassAlias("br.poli.ecomp.geav.nhe.model.server.LoginStatus",LoginStatus);
			registerClassAlias("br.poli.ecomp.geav.nhe.model.server.ProcedureResponse",ProcedureResponse);
		}
		
		public function connect():void
		{
			if(!NResponder.has(NetStatusEvent.NET_STATUS))
				NResponder.addNative(pro_red5_connection, NetStatusEvent.NET_STATUS, red5_connection_status_event);
			trace(ServerDefaults.RED5_PROTOCOL + "://" + 
				this.pas_host + ":" + ServerDefaults.RED5_PORT + "/" +
				ServerDefaults.RED5_APPLICATION);
			pro_red5_connection.connect(ServerDefaults.RED5_PROTOCOL + "://" + 
										this.pas_host + ":" + ServerDefaults.RED5_PORT + "/" +
										ServerDefaults.RED5_APPLICATION);
		}
		
		public function red5_connection_status_event(e:NetStatusEvent):void
		{
			trace(e.info.code);
			switch(e.info.code)
			{
				case "NetConnection.Connect.Success":
					this._prb_connected = true;
					break;
				case "NetConnection.Connect.Rejected":
					this._prb_connected = false;
					break;
				case "NetConnection.Connect.Closed":
					this._prb_connected = false;
					break;
				case "NetConnection.Connect.Failed":
					this._prb_connected = false;
					break;
			}
			NResponder.dispatch(CONNECTION_STATUS,[prb_connected]);
		}
		
		public function disconnect():void
		{
			pro_red5_connection.close();
		}
		
		public function login(user:String, password:String):void
		{
			pro_red5_connection.call(ServerDefaults.FUNCTION_LOGIN, pnl_red5_responders[LOGIN_RESPONDER], user, password);
		}
		
		public function get prb_connected():Boolean
		{
			return _prb_connected;
		}

		public function set prb_connected(value:Boolean):void
		{
			_prb_connected = value;
		}
		
		private function login_responder_result_handler(object:*):void
		{
			if(object is LoginStatus)
			{
				var login_status:LoginStatus = LoginStatus(object);
				this._prb_logged = login_status.pab_logged;
				if(login_status.pao_user.data.length > 0)
				{
					this._pro_logged_user = new User();
					this._pro_logged_user.usr_identificador = Number(login_status.pao_user.get(0,"usr_identificador"));
					this._pro_logged_user.usr_name = String(login_status.pao_user.get(0,"usr_name"));
				}
			}
			else
			{
				this._prb_logged = false;
			}
			NResponder.dispatch(LOGIN_STATUS,[this._prb_logged]);
		}
		
		private function login_responder_status_handler(object:*):void
		{
			this._prb_logged = false;
			NResponder.dispatch(LOGIN_STATUS,[this._prb_logged]);
		}
		
		private function create_project_responder_result_handler(object:*):void
		{
			
		}
		
		private function create_project_responder_status_handler(object:*):void
		{
			
		}
	}
}