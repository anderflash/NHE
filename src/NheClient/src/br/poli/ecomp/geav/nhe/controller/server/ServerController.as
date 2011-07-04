package br.poli.ecomp.geav.nhe.controller.server
{
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.model.db.pro.Project;
	import br.poli.ecomp.geav.nhe.model.db.usr.User;
	import br.poli.ecomp.geav.nhe.model.server.LoginStatus;
	import br.poli.ecomp.geav.nhe.model.server.ProcedureResponse;
	import br.poli.ecomp.geav.nhe.model.server.ServerDefaults;
	import br.poli.ecomp.geav.nhe.model.server.ServerResponse;
	
	import flash.events.AsyncErrorEvent;
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
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;

	public class ServerController
	{
		// Responders name
		private static const LOGIN_RESPONDER:Number = 0;
		private static const CREATE_PROJECT_RESPONDER:Number = 1;
		private static const LOGOUT_RESPONDER:Number = 2;
		private static const LIST_PROJECTS_RESPONDER:Number = 3;
		private static const VIEW_PROJECT_RESPONDER:Number = 4;
		
		// Events
		public static const MODEL_UPLOADED:String = "MODEL_UPLOADED";
		public static const MODEL_NOT_UPLOADED:String = "MODEL_NOT_UPLOADED";
		public static const LOGIN_STATUS:String = "LOGIN_STATUS";
		public static const LOGOUT_STATUS:String = "LOGOUT_STATUS";
		public static const CONNECTION_STATUS:String = "CONNECTION_STATUS";
		public static const PROJECTS_LISTED:String = "PROJECTS_LISTED";
		public static const PROJECT_CREATED:String = "PROJECT_CREATED";
		public static const VIEW_PROJECT_SERVER_COMPLETED:String = "VIEW_PROJECT_SERVER_COMPLETED";
		public static const VIEW_PROJECT_SERVER_FORBIDDEN:String = "VIEW_PROJECT_SERVER_FORBIDDEN";
		
		// Singleton
		private static var _instance:ServerController = new ServerController();
		
		private var pro_red5_connection:NetConnection;
		private var pro_cumulus_connection:NetConnection;
		private var pro_net_group:NetGroup;
		private var pro_send_stream:NetStream;
		private var pro_receive_stream:NetStream;
		
		private var _pas_host:String;
		
		private var _prb_connected:Boolean;
		private var _prb_rtmfp_connected:Boolean;
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
		
		public function view_project(project:Project):void
		{
			pro_red5_connection.call(ServerDefaults.FUNCTION_VIEW_PROJECT, pnl_red5_responders[VIEW_PROJECT_RESPONDER],project.pro_identificador);
		}
		
		public function uploadFile(fileReference:FileReference, pro_identificador:Number):void
		{
			if(!NResponder.has(DataEvent.UPLOAD_COMPLETE_DATA))
			{
				NResponder.addNative(fileReference, DataEvent.UPLOAD_COMPLETE_DATA, filereference_upload_complete_event);
				NResponder.addNative(fileReference, Event.CANCEL, filereference_cancel_event);
				NResponder.addNative(fileReference, Event.COMPLETE, filereference_complete_event);
				NResponder.addNative(fileReference, Event.OPEN, filereference_open_event);
				NResponder.addNative(fileReference, IOErrorEvent.IO_ERROR, filereference_io_error_event);
				NResponder.addNative(fileReference, ProgressEvent.PROGRESS, filereference_progress_event);
				NResponder.addNative(fileReference, SecurityErrorEvent.SECURITY_ERROR, filereference_security_error_event);
			}
			var urlVariables:URLVariables = new URLVariables();
			urlVariables.pro_identificador = String(pro_identificador);
			var urlRequest:URLRequest = new URLRequest("http://" + 
				this.pas_host + ":" + ServerDefaults.RED5_HTTP_PORT + "/" + 
				ServerDefaults.RED5_APPLICATION + "/" + 
				ServerDefaults.FILE_UPLOAD_SERVLET);
			urlRequest.data = urlVariables;
			urlRequest.method = URLRequestMethod.POST;
			fileReference.upload(urlRequest);
		}
		private function filereference_upload_complete_event(e:DataEvent):void
		{
			trace(e.type);
			
		}
		private function filereference_cancel_event(e:Event):void
		{
			
		}
		private function filereference_complete_event(e:Event):void
		{
			trace(e.type);
			NResponder.dispatch(MODEL_UPLOADED);
		}
		private function filereference_open_event(e:Event):void
		{
			trace(e.type);
		}
		private function filereference_io_error_event(e:IOErrorEvent):void
		{
			trace(e.text);
			NResponder.dispatch(MODEL_NOT_UPLOADED);
		}
		private function filereference_progress_event(e:ProgressEvent):void
		{
			
		}
		private function filereference_security_error_event(e:SecurityErrorEvent):void
		{
			NResponder.dispatch(MODEL_NOT_UPLOADED);
		}
		
		public function createProject(title:String, description:String, model:String, participants:Array):void
		{
			pro_red5_connection.call(ServerDefaults.FUNCTION_CREATE_PROJECT, pnl_red5_responders[CREATE_PROJECT_RESPONDER], title, description, model, participants, this._pro_logged_user.usr_identificador);
		}
		
		public function setup(host:String):void
		{
			this._pas_host = host;
			pro_red5_connection = new NetConnection();
			pro_cumulus_connection = new NetConnection();
			
			pnl_red5_responders = new Vector.<Responder>();
			
			// Populate Responders
			pnl_red5_responders.push(new Responder(login_responder_result_handler, login_responder_status_handler));
			pnl_red5_responders.push(new Responder(create_project_responder_result_handler, create_project_responder_result_handler));
			pnl_red5_responders.push(new Responder(logout_responder_result_handler, logout_responder_status_handler));
			pnl_red5_responders.push(new Responder(list_projects_responder_result_handler, list_projects_responder_status_handler));
			pnl_red5_responders.push(new Responder(view_project_responder_result_handler, view_project_responder_status_handler));
			
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
		
		public function logout():void
		{
			pro_red5_connection.call(ServerDefaults.FUNCTION_LOGOUT, pnl_red5_responders[LOGOUT_RESPONDER]);
		}
		
		public function listProjects():void
		{
			pro_red5_connection.call(ServerDefaults.FUNCTION_LIST_PROJECTS, pnl_red5_responders[LIST_PROJECTS_RESPONDER]);
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
					this._pro_logged_user.usr_login = String(login_status.pao_user.get(0,"usr_login"));
					this._pro_logged_user.usr_senha = String(login_status.pao_user.get(0,"usr_password"));
					this._pro_logged_user.usr_email = String(login_status.pao_user.get(0,"usr_email"));
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
			
			NResponder.dispatch(PROJECT_CREATED, [Number(object)]);
		}
		 	
		private function create_project_responder_status_handler(object:*):void
		{
			
		}
		
		private function logout_responder_result_handler(object:*):void
		{
			if(object is LoginStatus)
			{
				if(LoginStatus(object).pab_logged == false)
				{
					NResponder.dispatch(LOGOUT_STATUS,[LoginStatus(object).pab_logged]);
				}
			}
		}
		
		private function logout_responder_status_handler(object:*):void
		{
			
		}
		
		private function list_projects_responder_result_handler(object:*):void
		{
			NResponder.dispatch(PROJECTS_LISTED, [ProcedureResponse(object).data]);
		}
		
		private function list_projects_responder_status_handler(object:*):void
		{
			
		}
		
		private function view_project_responder_result_handler(object:*):void
		{
			if(Boolean(object))
			{
				NResponder.dispatch(VIEW_PROJECT_SERVER_COMPLETED);
				if(!NResponder.has(NetStatusEvent.NET_STATUS,cumulus_connection_status_event))
				{
					NResponder.addNative(pro_cumulus_connection, NetStatusEvent.NET_STATUS, cumulus_connection_status_event);
					NResponder.addNative(pro_cumulus_connection, IOErrorEvent.IO_ERROR, cumulus_connection_io_error_event);
					NResponder.addNative(pro_cumulus_connection, SecurityErrorEvent.SECURITY_ERROR, cumulus_connection_security_error_event);
					NResponder.addNative(pro_cumulus_connection, AsyncErrorEvent.ASYNC_ERROR, cumulus_connection_async_error_event);
				}
				trace("Conectando ao cumulus");
				pro_cumulus_connection.connect(ServerDefaults.CUMULUS_PROTOCOL + "://" + 
					this.pas_host + ":" + ServerDefaults.CUMULUS_PORT);
				
			}
			else
			{
				
			}
		}
		
		private function view_project_responder_status_handler(object:*):void
		{
			
		}
		
		private function cumulus_connection_status_event(e:NetStatusEvent):void
		{
			trace("Cumulus: " + e.info.code);
			switch(e.info.code)
			{
				case "NetConnection.Connect.Success":
					
					break;
				case "NetGroup.Connect.Success":
					
					break;
				case "NetConnection.Connect.Success":
					
					break;
				case "NetConnection.Connect.Success":
					
					break;
			}
		}
		
		private function cumulus_connection_io_error_event(e:IOErrorEvent):void
		{
			
		}
		
		private function cumulus_connection_security_error_event(e:SecurityErrorEvent):void
		{
			
		}
		
		private function cumulus_connection_async_error_event(e:AsyncErrorEvent):void
		{
			
		}
		
		public function get fullPath():String
		{
			return "http://" + this.pas_host + ":" + ServerDefaults.RED5_HTTP_PORT + "/" + 
				ServerDefaults.RED5_APPLICATION;
		}
		
		

		public function get pas_host():String
		{
			return _pas_host;
		}

		public function get prb_rtmfp_connected():Boolean
		{
			return _prb_rtmfp_connected;
		}
		
		
	}
}