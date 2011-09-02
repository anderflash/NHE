package br.poli.ecomp.geav.nhe.view.gui
{
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.model.db.Database;
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.cpl.Couple;
	import br.poli.ecomp.geav.nhe.model.db.pro.Project;
	
	import flash.events.MouseEvent;
	
	import org.aswing.AsWingConstants;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JList;
	import org.aswing.JMenu;
	import org.aswing.JToolBar;
	import org.aswing.SoftBoxLayout;
	import org.aswing.VectorListModel;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.event.ListItemEvent;
	
	public class MainView extends JFrame
	{
		public static const CREATE_PROJECT_CLICKED:String = "CREATE_PROJECT_CLICKED";
		public static const VIEW_PROJECT_CLICKED:String = "VIEW_PROJECT_CLICKED";
		public static const LOGOUT_CLICKED:String = "LOGOUT_CLICKED";
		public static const ABOUT_CLICKED:String = "ABOUT_CLICKED";
		
		private var vct_projects:VectorListModel;
		
		private var lst_projects:JList;
		private var tbr_toolbar:JToolBar;
		private var btn_create_project:JButton;
		private var btn_view_project:JButton;
		private var btn_logout:JButton;
		private var btn_about:JButton;
		
		public function MainView(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, title, modal);
			
			//component creation
			getContentPane().setLayout(new SoftBoxLayout(AsWingConstants.VERTICAL));
			
			tbr_toolbar = new JToolBar();
			
			btn_create_project = new JButton("&Create Project");
			
			btn_view_project = new JButton("&View Project");
			
			btn_logout = new JButton("&Logout");
			
			btn_about = new JButton("&About");
			
			vct_projects = new VectorListModel();
			lst_projects = new JList(vct_projects);
			lst_projects.setVisibleRowCount(10);
			
			//component layoution
			getContentPane().append(tbr_toolbar);
			getContentPane().append(lst_projects);
			
			tbr_toolbar.append(btn_create_project);
			tbr_toolbar.append(btn_view_project);
			tbr_toolbar.append(btn_logout);
			tbr_toolbar.append(btn_about);
			
			pack();
			
			configureListeners();
			btn_view_project_update_enabled();
			setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
		}
		
		public function listProjects(projects:Array):void
		{
			
			vct_projects.clear();
			for(var i:uint = 0; i < projects.length; i++)
			{
				var projeto:Project = new Project();
				projeto.pro_identificador = projects[i][0];
				projeto.pro_title = projects[i][1];
				projeto.pro_description = projects[i][2];
				projeto.pro_finished = projects[i][3];
				if(projects[i][4])
				{
					projeto.act_identificador = new Action();
					projeto.act_identificador.act_identificador = projects[i][4];
				}
				projeto.pro_model_path = projects[i][5];
				if(projects[i][6])
				{
					projeto.cpl_identificador = new Couple();
					projeto.cpl_identificador.cpl_identificador = projects[i][6];
										
				}
				vct_projects.append(projeto);
			}
		}
		
		private function configureListeners():void
		{
			NResponder.addNative(lst_projects, ListItemEvent.ITEM_CLICK, list_projects_item_clicked_event);
			NResponder.addNative(btn_view_project, MouseEvent.CLICK, btn_view_project_click_event);
			NResponder.addNative(btn_create_project, MouseEvent.CLICK, btn_create_project_click_event);
			NResponder.addNative(btn_about, MouseEvent.CLICK, btn_about_click_event);
			NResponder.addNative(btn_logout, MouseEvent.CLICK, btn_logout_click_event);
		}
		
		private function list_projects_item_clicked_event(e:ListItemEvent):void
		{
			btn_view_project_update_enabled();
		}
		
		private function btn_view_project_update_enabled():void
		{
			if(lst_projects.getSelectedIndex() != -1)
				btn_view_project.setEnabled(true);
			else
				btn_view_project.setEnabled(false);
		}
		
		public function get selected_project():Project
		{
			return lst_projects.getSelectedValue() as Project;
		}
		
		private function btn_create_project_click_event(e:MouseEvent):void
		{
			NResponder.dispatch(CREATE_PROJECT_CLICKED);
		}
		private function btn_view_project_click_event(e:MouseEvent):void
		{
			NResponder.dispatch(VIEW_PROJECT_CLICKED);
		}
		private function btn_logout_click_event(e:MouseEvent):void
		{
			NResponder.dispatch(LOGOUT_CLICKED);
		}
		private function btn_about_click_event(e:MouseEvent):void
		{
			NResponder.dispatch(ABOUT_CLICKED);
		}
	}
}