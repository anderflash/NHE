package br.poli.ecomp.geav.nhe.controller.server
{
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.model.db.Database;
	import br.poli.ecomp.geav.nhe.model.db.pfl.Profile;
	import br.poli.ecomp.geav.nhe.model.db.pro.Project;
	import br.poli.ecomp.geav.nhe.model.db.ptc.Participation;
	import br.poli.ecomp.geav.nhe.model.db.usr.User;
	import br.poli.ecomp.geav.nhe.model.server.LoginStatus;
	import br.poli.ecomp.geav.nhe.model.server.ProcedureResponse;
	import br.poli.ecomp.geav.nhe.model.server.ServerDefaults;
	import br.poli.ecomp.geav.nhe.model.server.ServerResponse;
	import br.poli.ecomp.geav.nhe.view.gui.AboutView;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.FileReference;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	import flash.net.NetStream;
	import flash.net.Responder;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	
	import marcozero.marzsdk.net.db.IMZTable;
	import marcozero.marzsdk.net.db.MZOperators;

	public class ServerController
	{
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
		
		private var pnl_red5_responders:Dictionary;
		
		private var project_participants:Vector.<Participation>;
		private var project:Project;
		
		/*--------------------------------------------
		 * 				 PUBLIC METHODS
		 ---------------------------------------------*/
		/**
		 * Constructor, you can't instantiate. It's a Singleton <br>
		 * Use the instance property. 
		 * 
		 */
		public function ServerController()
		{
			if(_instance) throw new Error("Singleton on ServerController");
		}
		/**
		 * Setup the connection 
		 * @param host
		 * 
		 */
		public function setup(host:String):void
		{
			this._pas_host = host;
			pro_red5_connection = new NetConnection();
			pro_cumulus_connection = new NetConnection();
			
			pnl_red5_responders = new Dictionary();
			
			// Populate Responders
			
			pnl_red5_responders[ServerDefaults.FUNCTION_LOGIN] 				= new Responder(login_responder_result_handler, login_responder_status_handler);
			pnl_red5_responders[ServerDefaults.FUNCTION_CREATE_PROJECT] 	= new Responder(create_project_responder_result_handler, create_project_responder_result_handler);
			pnl_red5_responders[ServerDefaults.FUNCTION_LOGOUT] 			= new Responder(logout_responder_result_handler, logout_responder_status_handler);
			pnl_red5_responders[ServerDefaults.FUNCTION_LIST_PROJECTS] 		= new Responder(list_projects_responder_result_handler, list_projects_responder_status_handler);
			pnl_red5_responders[ServerDefaults.FUNCTION_VIEW_PROJECT] 		= new Responder(view_project_responder_result_handler, view_project_responder_status_handler);
			pnl_red5_responders[ServerDefaults.FUNCTION_LIST_COMPONENTS] 	= new Responder(list_components_responder_result_handler, list_components_responder_status_handler);
			pnl_red5_responders[ServerDefaults.FUNCTION_ADD_BLOCK] 			= new Responder(add_block_responder_result_handler, add_block_responder_status_handler);
			pnl_red5_responders[ServerDefaults.FUNCTION_REMOVE_BLOCK] 		= new Responder(remove_block_responder_result_handler, remove_block_responder_status_handler);
			pnl_red5_responders[ServerDefaults.FUNCTION_MOVE_BLOCK] 		= new Responder(move_block_responder_result_handler, move_block_responder_status_handler);
			pnl_red5_responders[ServerDefaults.FUNCTION_CONNECT_BLOCKS] 	= new Responder(connect_blocks_responder_result_handler, connect_blocks_responder_status_handler);
			pnl_red5_responders[ServerDefaults.FUNCTION_DISCONNECT_BLOCKS] 	= new Responder(disconnect_blocks_responder_result_handler, disconnect_blocks_responder_status_handler);
			pnl_red5_responders[ServerDefaults.FUNCTION_LIST_PARTICIPANTS] 	= new Responder(list_participants_responder_result_handler, list_participants_responder_status_handler);
			
			
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
		
		public function disconnect():void
		{
			pro_red5_connection.close();
		}
		
		public function login(user:String, password:String):void
		{
			pro_red5_connection.call(ServerDefaults.FUNCTION_LOGIN, pnl_red5_responders[ServerDefaults.FUNCTION_LOGIN], user, password);
		}
		
		public function logout():void
		{
			pro_red5_connection.call(ServerDefaults.FUNCTION_LOGOUT, pnl_red5_responders[ServerDefaults.FUNCTION_LOGOUT]);
		}
		
		/**
		 * Create Project 
		 * @param title
		 * @param description
		 * @param model
		 * @param participants
		 * 
		 */
		public function createProject(title:String, description:String, model:String, participants:Array):void
		{
			pro_red5_connection.call(ServerDefaults.FUNCTION_CREATE_PROJECT, pnl_red5_responders[ServerDefaults.FUNCTION_CREATE_PROJECT], title, description, model, participants, this._pro_logged_user.usr_identificador);
		}
				
		/**
		 * Upload a zip model to a project 
		 * @param fileReference
		 * @param pro_identificador
		 * 
		 */
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
		
		
		
		public function listProjects():void
		{
			pro_red5_connection.call(ServerDefaults.FUNCTION_LIST_PROJECTS, pnl_red5_responders[ServerDefaults.FUNCTION_LIST_PROJECTS]);
		}
		
		/**
		 * Enter in the project to participate to the model   
		 * @param project
		 * 
		 */
		public function view_project(project:Project):void
		{
			this.project = project;
			pro_red5_connection.call(ServerDefaults.FUNCTION_VIEW_PROJECT, pnl_red5_responders[ServerDefaults.FUNCTION_VIEW_PROJECT],project.pro_identificador);
		}

		public function listComponents(pro_identificador:Number):void
		{
			pro_red5_connection.call(ServerDefaults.FUNCTION_LIST_COMPONENTS, pnl_red5_responders[ServerDefaults.FUNCTION_LIST_COMPONENTS]);
		}
		
		public function addBlock():void
		{
			
		}
		
		public function removeBlock():void
		{
			
		}
		
		public function moveBlock():void
		{
			
		}
		
		public function connectBlocks():void
		{
			
		}
		
		public function banUser():void
		{
			
		}
		
		public function finishProject():void
		{
			
		}
		
		public function message_send():void
		{
			
		}
		
		/*--------------------------------------------
		* 				 PROPERTIES
		---------------------------------------------*/
		
		public static function get instance():ServerController
		{
			return _instance;
		}
		
		public function get prb_connected():Boolean
		{
			return _prb_connected;
		}
		
		public function set prb_connected(value:Boolean):void
		{
			_prb_connected = value;
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
		
		/*--------------------------------------------
		* 				 PRIVATE METHODS
		---------------------------------------------*/
		private function red5_connection_status_event(e:NetStatusEvent):void
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
		
		
		
		private function login_responder_result_handler(object:*):void
		{
			if(object is LoginStatus)
			{
				var login_status:LoginStatus = LoginStatus(object);
				this._prb_logged = login_status.pab_logged;
				if(login_status.pao_user)
				{
					if(login_status.pao_user.data.length > 0)
					{
						this._pro_logged_user = new User();
						this._pro_logged_user.usr_identificador = Number(login_status.pao_user.get(0,"usr_identificador"));
						this._pro_logged_user.usr_name = String(login_status.pao_user.get(0,"usr_name"));
						this._pro_logged_user.usr_login = String(login_status.pao_user.get(0,"usr_login"));
						this._pro_logged_user.usr_password = String(login_status.pao_user.get(0,"usr_password"));
						this._pro_logged_user.usr_email = String(login_status.pao_user.get(0,"usr_email"));
						
						this._pro_logged_user = Database.instance.repositorio(Database.USER_STR).adicionarComCuidado(this._pro_logged_user) as User;
					}
				}
				else
				{
					this._prb_logged = false;
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
		
		// Resultado da função View Project
		// Chamar o listar Participantes
		private function view_project_responder_result_handler(object:*):void
		{
			if(object is ProcedureResponse)
			{
				if(ProcedureResponse(object).data[0][0] == true)
					pro_red5_connection.call(ServerDefaults.FUNCTION_LIST_PARTICIPANTS, pnl_red5_responders[ServerDefaults.FUNCTION_LIST_PARTICIPANTS],project.pro_identificador);
			}
			else
			{
				
			}
		}
		
		private function view_project_responder_status_handler(object:*):void
		{
			
		}

		// Resposta da função Listar Participantes
		// Guardar os participantes e Conectar ao Cumulus
		private function list_participants_responder_result_handler(object:*):void
		{
			if(object is Array)
			{
				var responseUsr:ProcedureResponse = (object as Array)[0] as ProcedureResponse;
				var responsePtc:ProcedureResponse = (object as Array)[1] as ProcedureResponse;
				
				project_participants = new Vector.<Participation>();
				
				for(var i:uint = 0; i < responseUsr.data.length; i++)
				{
					var user:User = new User();
					user.usr_identificador	= responseUsr[i][responseUsr.fields.indexOf("usr_identificador")];
					user.usr_login			= responseUsr[i][responseUsr.fields.indexOf("usr_login")];
					user.usr_name			= responseUsr[i][responseUsr.fields.indexOf("usr_name")];
					user.usr_password		= responseUsr[i][responseUsr.fields.indexOf("usr_password")];
					user.usr_email			= responseUsr[i][responseUsr.fields.indexOf("usr_email")];
					
					user = Database.instance.repositorio(Database.USER_STR).adicionarComCuidado(user) as User;
					
					
					var participation:Participation = new Participation();
					participation.pfl_identificador = new Profile();
					participation.pfl_identificador.pfl_identificador = responsePtc[i][responsePtc.fields.indexOf("pfl_identificador")];
					Database.instance.repositorio(Database.PROFILE_STR).adicionarComCuidado(participation.pfl_identificador);
					participation.pro_identificador = new Project();
					participation.pro_identificador.pro_identificador = responsePtc[i][responsePtc.fields.indexOf("pro_identificador")];
					Database.instance.repositorio(Database.PROJECT_STR).adicionarComCuidado(participation.pro_identificador);
					
					participation.ptc_identificador = responsePtc[i][responsePtc.fields.indexOf("ptc_identificador")];
					participation.usr_identificador = user;
					Database.instance.repositorio(Database.PARTICIPATION_STR).adicionarComCuidado(participation);
					project_participants.push(participation);
				}
				
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
		}
		
		private function list_participants_responder_status_handler(object:*):void
		{
			
		}
		
		private function list_components_responder_result_handler(object:*):void
		{
			
		}
		
		private function list_components_responder_status_handler(object:*):void
		{
			
		}
		
		private function add_block_responder_result_handler(object:*):void
		{
			
		}
		
		private function remove_block_responder_result_handler(object:*):void
		{
			
		}
		
		private function move_block_responder_result_handler(object:*):void
		{
			
		}
		
		private function connect_blocks_responder_result_handler(object:*):void
		{
			
		}
		
		private function disconnect_blocks_responder_result_handler(object:*):void
		{
			
		}
		
		private function add_block_responder_status_handler(object:*):void
		{
			
		}
		
		private function remove_block_responder_status_handler(object:*):void
		{
			
		}
		
		private function move_block_responder_status_handler(object:*):void
		{
			
		}
		
		private function connect_blocks_responder_status_handler(object:*):void
		{
			
		}
		
		private function disconnect_blocks_responder_status_handler(object:*):void
		{
			
		}
		
		private function cumulus_connection_status_event(e:NetStatusEvent):void
		{
			trace("Cumulus: " + e.info.code);
			switch(e.info.code)
			{
				case "NetConnection.Connect.Success":
					var groupSpec:GroupSpecifier = new GroupSpecifier("NHE_ROOMS/" + String(project.pro_identificador));
					groupSpec.serverChannelEnabled = true;
					groupSpec.postingEnabled = true;
					
					pro_send_stream = new NetStream(pro_cumulus_connection, groupSpec.groupspecWithAuthorizations());
					NResponder.addNative(pro_send_stream, NetStatusEvent.NET_STATUS, cumulus_connection_status_event);
					pro_receive_stream = new NetStream(pro_cumulus_connection, groupSpec.groupspecWithAuthorizations());
					NResponder.addNative(pro_receive_stream, NetStatusEvent.NET_STATUS, cumulus_connection_status_event);
					
					pro_net_group = new NetGroup(pro_cumulus_connection,groupSpec.groupspecWithAuthorizations());
					NResponder.addNative(pro_net_group, NetStatusEvent.NET_STATUS, cumulus_connection_status_event);
					break;
				case "NetGroup.Connect.Success":
					if(e.currentTarget == pro_net_group)
					{
						
					}
					break;
				case "NetConnection.Connect.Success":
					
					break;
				case "NetConnection.Connect.Success":
					
					break;
				
				case "NetStream.Connect.Success":
					if(e.currentTarget == pro_send_stream)
					{
						var ptcCriterio:Participation = new Participation();
						ptcCriterio.usr_identificador = _pro_logged_user;
						ptcCriterio = Database.instance.repositorio(Database.PARTICIPATION_STR).procurar(ptcCriterio, MZOperators.AND, {usr_identificador: MZOperators.EQUAL}) as Participation;
						// Se for dono do projeto, posta a webcam
						if(ptcCriterio.pfl_identificador.pfl_identificador == 2)
						{
							pro_send_stream.attachCamera(Camera.getCamera());
							pro_send_stream.publish("nhe_user_" + String(_pro_logged_user.usr_identificador));
						}
					}
					else if(e.currentTarget == pro_receive_stream)
					{
						
						// Se não for dono, recebe a webcam
						if(ptcCriterio.pfl_identificador.pfl_identificador != 2)
						{
							
							var participation:Participation = new Participation();
							participation.pro_identificador = project;
							var result:Vector.<IMZTable> = Database.instance.repositorio(Database.PARTICIPATION_STR).procurarLista(participation, MZOperators.AND, {pro_identificador:MZOperators.EQUAL});
							// Procura o dono e recebe a cam dele
							for(var i:uint =0 ; i < result.length; i++)
							{
								if(Participation(result[i]).pfl_identificador.pfl_identificador == 2)
								{
									pro_receive_stream.play("nhe_user_" + String(Participation(result[i]).usr_identificador.usr_identificador));
								}
							}
						}
						
						NResponder.dispatch(VIEW_PROJECT_SERVER_COMPLETED);
					}
					else
					{
						
					}
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
		
				
	}
}