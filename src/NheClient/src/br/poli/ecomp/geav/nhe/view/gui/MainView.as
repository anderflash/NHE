package br.poli.ecomp.geav.nhe.view.gui
{
	import appkit.responders.NResponder;
	
	import flash.events.MouseEvent;
	
	import org.aswing.AsWingConstants;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JList;
	import org.aswing.JMenu;
	import org.aswing.JToolBar;
	import org.aswing.SoftBoxLayout;
	import org.aswing.event.InteractiveEvent;
	
	public class MainView extends JFrame
	{
		public static const CREATE_PROJECT_CLICKED:String = "CREATE_PROJECT_CLICKED";
		public static const VIEW_PROJECT_CLICKED:String = "VIEW_PROJECT_CLICKED";
		public static const LOGOUT_CLICKED:String = "LOGOUT_CLICKED";
		public static const ABOUT_CLICKED:String = "ABOUT_CLICKED";
		
		
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
			
			lst_projects = new JList();
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
		
		private function configureListeners():void
		{
			NResponder.addNative(lst_projects, InteractiveEvent.STATE_CHANGED, list_projects_state_changed);
			NResponder.addNative(btn_view_project, MouseEvent.CLICK, btn_view_project_click_event);
			NResponder.addNative(btn_create_project, MouseEvent.CLICK, btn_create_project_click_event);
			NResponder.addNative(btn_about, MouseEvent.CLICK, btn_about_click_event);
			NResponder.addNative(btn_logout, MouseEvent.CLICK, btn_logout_click_event);
		}
		
		private function list_projects_state_changed(e:InteractiveEvent):void
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