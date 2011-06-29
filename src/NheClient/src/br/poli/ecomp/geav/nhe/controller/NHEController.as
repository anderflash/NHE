package br.poli.ecomp.geav.nhe.controller
{
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.controller.action.ActionController;
	import br.poli.ecomp.geav.nhe.controller.augmentedreality.ARController;
	import br.poli.ecomp.geav.nhe.controller.db.DBController;
	import br.poli.ecomp.geav.nhe.controller.server.ServerController;
	import br.poli.ecomp.geav.nhe.controller.world.WorldController;
	import br.poli.ecomp.geav.nhe.view.NHEView;
	import br.poli.ecomp.geav.nhe.view.gui.LoginView;
	import br.poli.ecomp.geav.nhe.view.gui.MainView;
	import br.poli.ecomp.geav.nhe.view.gui.ProjectCreationView;
	
	import flash.display.Stage;
	import flash.net.URLRequest;
	
	import org.aswing.AsWingManager;
	import org.aswing.JOptionPane;
	import org.aswing.event.FrameEvent;

	public class NHEController
	{
		
		private var stage:Stage;
		private var _prv_nhe_view:NHEView;
		
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
			AsWingManager.initAsStandard(stage);
		}
		
		public function setup():void
		{
			create_view();
			create_controllers();
			
			NResponder.add(ServerController.CONNECTION_STATUS, connection_status_handler);
			
			var host:String;
			try{ host = stage.loaderInfo.url.split("/")[2];} catch(e:Error){ host = "localhost"; }
			if(host.length == 0) host = "localhost";
			
			ServerController.instance.setup(stage.loaderInfo.url.split("/")[2]);
			
			ServerController.instance.connect();
		}
		
		public function start():void
		{
			stage.addChild(prv_nhe_view);
			if(ServerController.instance.prb_connected)
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
			/*pro_server_controller = new ServerController();
			pro_db_controller = new DBController(pro_server_controller);
			pro_ar_controller = new ARController(stage);
			pro_action_controller = new ActionController(pro_db_controller, pro_server_controller, pro_ar_controller);
			pro_world_controller = new WorldController(stage);*/
		}
		
		private function create_view():void
		{
			this._prv_nhe_view = new NHEView();
			NResponder.add(LoginView.LOGIN_CLICKED, login_clicked_event);
		}
		
		private function login_clicked_event():void
		{
			if(!NResponder.has(ServerController.LOGIN_STATUS))
				NResponder.add(ServerController.LOGIN_STATUS, login_status_handler);
			ServerController.instance.login(	this._prv_nhe_view.prv_login_view.user,
												this._prv_nhe_view.prv_login_view.password);
		}
		
		private function connection_status_handler(connected:Boolean):void
		{
			NResponder.dispatch(CREATION_COMPLETE);
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
					NResponder.add(ProjectCreationView.CANCEL_CLICKED, project_creation_cancel_clicked_handler);
					NResponder.add(ProjectCreationView.SAVE_CLICKED, project_creation_save_clicked_handler);
					NResponder.addNative(this._prv_nhe_view.prv_main_view, FrameEvent.FRAME_CLOSING, main_view_closing_event); 
				}
				this._prv_nhe_view.prv_main_view.show();
			}
		}
		private function create_project_clicked_handler():void
		{
			this._prv_nhe_view.prv_project_creation_view.clear();
			this._prv_nhe_view.prv_project_creation_view.show();
		}
		
		private function about_clicked_handler():void
		{
			this._prv_nhe_view.prv_about_view.show();
		}
		
		private function view_project_clicked_handler():void
		{
			this._prv_nhe_view.prv_main_view.hide();
			this._prv_nhe_view.prv_project_view.show();
		}
		
		private function logout_clicked_handler():void
		{
			this._prv_nhe_view.prv_main_view.hide();
			this._prv_nhe_view.prv_login_view.show();
			this._prv_nhe_view.prv_login_view.clear();
		}
		
		private function main_view_closing_event(e:FrameEvent):void
		{
			this._prv_nhe_view.prv_login_view.show();
		}
		
		private function project_creation_save_clicked_handler():void
		{
			var projView:ProjectCreationView  = this._prv_nhe_view.prv_project_creation_view;
			if(!NResponder.has(ServerController.MODEL_NOT_UPLOADED))
				NResponder.add(ServerController.MODEL_NOT_UPLOADED, model_not_uploaded_handler);
			ServerController.instance.uploadFile(projView.pro_reference);
			
			ServerController.instance.createProject(projView.project_title, projView.project_description, projView.project_model_file, projView.project_participants);
			this._prv_nhe_view.prv_project_creation_view.hide();
		}
		
		private function model_not_uploaded_handler():void
		{
			JOptionPane.showMessageDialog("Create Project Error","Error on creating project: Model not uploaded");
			
		}
		
		private function project_creation_cancel_clicked_handler():void
		{
			this._prv_nhe_view.prv_project_creation_view.hide();
		}
	}
}