package br.poli.ecomp.geav.nhe.view
{
	import br.poli.ecomp.geav.nhe.view.gui.AboutView;
	import br.poli.ecomp.geav.nhe.view.gui.LoginView;
	import br.poli.ecomp.geav.nhe.view.gui.MainView;
	import br.poli.ecomp.geav.nhe.view.gui.ProjectCreationView;
	import br.poli.ecomp.geav.nhe.view.gui.ProjectView;
	
	import flash.display.Sprite;
	
	public class NHEView extends Sprite
	{
		private var _prv_login_view:LoginView;
		private var _prv_main_view:MainView;
		private var _prv_project_view:ProjectView;
		private var _prv_project_creation_view:ProjectCreationView;
		private var _prv_about_view:AboutView;
				
		public function NHEView()
		{
			super();
			_prv_login_view = new LoginView(this, "NHE Login", true);
			_prv_main_view = new MainView(this, "NHE AR System for Modeling and Simulation", true);
			_prv_project_view = new ProjectView(this, "View Project", true);
			_prv_project_creation_view = new ProjectCreationView(this, "Create a Project", true);
			_prv_about_view = new AboutView(this, "About NHE Project", true);
		}

		public function get prv_login_view():LoginView
		{
			return _prv_login_view;
		}

		public function get prv_main_view():MainView
		{
			return _prv_main_view;
		}

		public function get prv_project_view():ProjectView
		{
			return _prv_project_view;
		}

		public function get prv_project_creation_view():ProjectCreationView
		{
			return _prv_project_creation_view;
		}

		public function get prv_about_view():AboutView
		{
			return _prv_about_view;
		}
	}
}