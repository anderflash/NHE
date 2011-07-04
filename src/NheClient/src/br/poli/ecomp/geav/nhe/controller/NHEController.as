package br.poli.ecomp.geav.nhe.controller
{
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.controller.action.ActionController;
	import br.poli.ecomp.geav.nhe.controller.augmentedreality.ARController;
	import br.poli.ecomp.geav.nhe.controller.db.DBController;
	import br.poli.ecomp.geav.nhe.controller.server.ServerController;
	import br.poli.ecomp.geav.nhe.controller.state.StateTreeController;
	import br.poli.ecomp.geav.nhe.controller.world.WorldController;
	import br.poli.ecomp.geav.nhe.view.NHEView;
	import br.poli.ecomp.geav.nhe.view.gui.LoginView;
	import br.poli.ecomp.geav.nhe.view.gui.MainView;
	import br.poli.ecomp.geav.nhe.view.gui.ProjectCreationView;
	import br.poli.ecomp.geav.nhe.view.gui.ProjectView;
	
	import com.hurlant.math.bi_internal;
	
	import flash.display.Stage;
	import flash.net.URLRequest;
	
	import org.aswing.AsWingManager;
	import org.aswing.JOptionPane;
	import org.aswing.event.FrameEvent;

	public class NHEController
	{
		
		private var stage:Stage;
		private var _prv_nhe_view:NHEView;
		private var creation_completed:Boolean;
		
		public static const CREATION_COMPLETE:String = "CREATION_COMPLETE";
		
		// Controllers
		private var pro_server_controller:ServerController;
		private var pro_world_controller:WorldController;
		private var pro_db_controller:DBController;
		private var pro_action_controller:ActionController;
		private var pro_ar_controller:ARController;
		private var pro_state_tree_controller:StateTreeController;
		
		/*------------------------------------
		* 			PUBLIC METHODS
		-----------------------------------*/
		public function NHEController(stage:Stage)
		{
			this.stage = stage;
			AsWingManager.initAsStandard(stage);
		}
		
		public function setup():void
		{
			create_controllers();
			
			NResponder.add(ServerController.CONNECTION_STATUS, connection_status_handler);
			pro_server_controller.connect();
		}
		
		public function start():void
		{
			stage.addChild(prv_nhe_view);
			if(pro_server_controller.prb_connected)
			{
				prv_nhe_view.prv_login_view.show();
			}
			else
			{
				JOptionPane.showMessageDialog("Server Connection", "Could not connect to server");
			}
		}
		
		/*------------------------------------
		* 			  PROPERTIES
		-----------------------------------*/
		public function get prv_nhe_view():NHEView
		{
			return _prv_nhe_view;
		}
		
		/*------------------------------------
		* 		   PRIVATE METHODS
		-----------------------------------*/
		private function create_controllers():void
		{
			pro_server_controller = ServerController.instance;
			var host:String;
			try{ host = stage.loaderInfo.url.split("/")[2];} catch(e:Error){ host = "localhost"; }
			if(host.length == 0) host = "localhost";
			pro_server_controller.setup(stage.loaderInfo.url.split("/")[2]);
			
			pro_db_controller = DBController.instance;
			pro_db_controller.setup();
			
			pro_action_controller = new ActionController(pro_db_controller, pro_server_controller, pro_ar_controller);
			
			pro_state_tree_controller = new StateTreeController();
			
			pro_world_controller = new WorldController(stage);
			pro_ar_controller = new ARController(pro_world_controller, stage);
			pro_ar_controller.setup();
			
			NResponder.add(ARController.STARTED, ar_controller_started);
		}
		
		private function ar_controller_started():void
		{
			pro_world_controller.setup(pro_ar_controller.asfeat.lib.getIntrinsicParams());
			create_view();
		}
		
		private function create_view():void
		{
			this._prv_nhe_view = new NHEView(pro_world_controller.prn_world_view, pro_state_tree_controller.pao_state_tree_view);
			NResponder.add(LoginView.LOGIN_CLICKED, login_clicked_event);
			creation_completed = true;
			
			if(pro_server_controller.prb_connected)
			{
				NResponder.dispatch(CREATION_COMPLETE);
			}
		}
		
		private function login_clicked_event():void
		{
			if(!NResponder.has(ServerController.LOGIN_STATUS))
				NResponder.add(ServerController.LOGIN_STATUS, login_status_handler);
			pro_server_controller.login(	this._prv_nhe_view.prv_login_view.user,
												this._prv_nhe_view.prv_login_view.password);
		}
		
		private function connection_status_handler(connected:Boolean):void
		{
			if(creation_completed == true)
			{
				NResponder.dispatch(CREATION_COMPLETE);
			}
			
			if(!connected)
			{
				this._prv_nhe_view.prv_main_view.hide();
				this._prv_nhe_view.prv_project_creation_view.hide();
				this._prv_nhe_view.prv_about_view.hide();
				this._prv_nhe_view.prv_project_view.hide();
				this._prv_nhe_view.prv_login_view.show();
			}
		}
		
		private function login_status_handler(logged:Boolean):void
		{
			if(logged)
			{
				this._prv_nhe_view.prv_login_view.clear();
				this._prv_nhe_view.prv_login_view.hide();
				if(!NResponder.has(MainView.CREATE_PROJECT_CLICKED))
				{
					NResponder.add(MainView.CREATE_PROJECT_CLICKED, create_project_clicked_handler);
					NResponder.add(MainView.ABOUT_CLICKED, about_clicked_handler);
					NResponder.add(MainView.VIEW_PROJECT_CLICKED, view_project_clicked_handler);
					NResponder.add(MainView.LOGOUT_CLICKED, logout_clicked_handler);
					NResponder.add(ServerController.PROJECTS_LISTED, projects_listed_handler);
					
					NResponder.addNative(this._prv_nhe_view.prv_main_view, FrameEvent.FRAME_CLOSING, main_view_closing_event); 
				}
				pro_server_controller.listProjects();
			}
			else
				JOptionPane.showMessageDialog("Login Inválido", "Login ou senha incorretos. Tente novamente.");
		}
		
		private function projects_listed_handler(projects:Array):void
		{
			this._prv_nhe_view.prv_main_view.show();
			this._prv_nhe_view.prv_main_view.listProjects(projects);
		}
		
		private function create_project_clicked_handler():void
		{
			if(!NResponder.has(ProjectCreationView.CANCEL_CLICKED))
			{
				NResponder.add(ProjectCreationView.CANCEL_CLICKED, project_creation_cancel_clicked_handler);
				NResponder.add(ProjectCreationView.SAVE_CLICKED, project_creation_save_clicked_handler);
			}
			this._prv_nhe_view.prv_project_creation_view.clear();
			this._prv_nhe_view.prv_project_creation_view.show();
		}
		
		private function about_clicked_handler():void
		{
			this._prv_nhe_view.prv_about_view.show();
		}
		
		private function view_project_clicked_handler():void
		{
			if(!NResponder.has(ServerController.VIEW_PROJECT_SERVER_COMPLETED))
			{
				NResponder.add(ServerController.VIEW_PROJECT_SERVER_COMPLETED, view_project_server_completed_handler);
				NResponder.add(ServerController.VIEW_PROJECT_SERVER_FORBIDDEN, view_project_server_forbidden_handler);
			}
			pro_server_controller.view_project(this._prv_nhe_view.prv_main_view.selected_project);
		}
		
		private function logout_clicked_handler():void
		{
			if(!NResponder.has(ServerController.LOGOUT_STATUS))
				NResponder.add(ServerController.LOGOUT_STATUS, logout_status_handler);				
			pro_server_controller.logout();
		}
		
		private function logout_status_handler(logged:Boolean):void
		{
			if(!logged)
			{
				this._prv_nhe_view.prv_main_view.hide();
				this._prv_nhe_view.prv_login_view.show();
				this._prv_nhe_view.prv_login_view.clear();
			}
			else
			{
				JOptionPane.showMessageDialog("Erro no logout", "Não conseguiu realizar o logout");
			}
		}
		
		private function main_view_closing_event(e:FrameEvent):void
		{
			this._prv_nhe_view.prv_login_view.show();
		}
		
		private function project_creation_save_clicked_handler():void
		{
			var projView:ProjectCreationView  = this._prv_nhe_view.prv_project_creation_view;
			if(!NResponder.has(ServerController.PROJECT_CREATED))
				NResponder.add(ServerController.PROJECT_CREATED, project_created_handler);
				
			pro_server_controller.createProject(projView.project_title, projView.project_description, projView.project_model_file, projView.project_participants);
			
		}
		
		private function model_not_uploaded_handler():void
		{
			JOptionPane.showMessageDialog("Create Project Error","Error on creating project: Model not uploaded");
		}
		
		private function project_created_handler(pro_identificador:Number):void
		{
			if(!NResponder.has(ServerController.MODEL_NOT_UPLOADED))
			{
				NResponder.add(ServerController.MODEL_NOT_UPLOADED, model_not_uploaded_handler);
				NResponder.add(ServerController.MODEL_UPLOADED, model_uploaded_handler);
			}
			var projView:ProjectCreationView  = this._prv_nhe_view.prv_project_creation_view;
			pro_server_controller.uploadFile(projView.pro_reference, pro_identificador);
		}
		private function model_uploaded_handler():void
		{
			JOptionPane.showMessageDialog("Projeto Criado", "Projeto criado com sucesso");
			this._prv_nhe_view.prv_project_creation_view.hide();
			pro_server_controller.listProjects();
		}
		
		private function project_creation_cancel_clicked_handler():void
		{
			this._prv_nhe_view.prv_project_creation_view.hide();
		}
		
		private function view_project_server_completed_handler():void
		{
			if(!NResponder.has(ProjectView.EXIT_CLICKED))
			{
				NResponder.add(ProjectView.EXIT_CLICKED, project_view_exit_clicked_handler);
				NResponder.add(ProjectView.FINISH_CLICKED, project_view_finish_clicked_handler);
				NResponder.add(ProjectView.SEND_CLICKED, project_view_send_clicked_handler);
				NResponder.add(ProjectView.BAN_CLICKED, project_view_ban_clicked_handler);
			}
			this._prv_nhe_view.prv_main_view.hide();
			this._prv_nhe_view.prv_project_view.show();
			this._prv_nhe_view.prv_project_view.pro_world_view.render_start();
			this._prv_nhe_view.prv_project_view.pack();
		}
		
		private function view_project_server_forbidden_handler():void
		{
			JOptionPane.showMessageDialog("View Project Error","You cannot view this project");
		}
		
		private function project_view_exit_clicked_handler():void
		{
			this._prv_nhe_view.prv_project_view.hide();
			this._prv_nhe_view.prv_project_view.pro_world_view.render_stop();
			this._prv_nhe_view.prv_main_view.show();
			
			pro_server_controller.listProjects();
			
		}
		
		private function project_view_send_clicked_handler():void
		{
			
		}
		
		private function project_view_finish_clicked_handler():void
		{
			
		}
		
		private function project_view_ban_clicked_handler():void
		{
			
		}
	}
}