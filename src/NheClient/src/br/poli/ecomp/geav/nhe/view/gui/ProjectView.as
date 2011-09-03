package br.poli.ecomp.geav.nhe.view.gui
{
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.model.db.usr.User;
	import br.poli.ecomp.geav.nhe.view.state.StateTreeView;
	import br.poli.ecomp.geav.nhe.view.world.WorldView;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.drm.AddToDeviceGroupSetting;
	
	import org.aswing.ASColor;
	import org.aswing.AsWingConstants;
	import org.aswing.AssetPane;
	import org.aswing.JButton;
	import org.aswing.JList;
	import org.aswing.JPanel;
	import org.aswing.JTextArea;
	import org.aswing.JToolBar;
	import org.aswing.JWindow;
	
	import org.aswing.LoadIcon;
	import org.aswing.SoftBoxLayout;
	import org.aswing.VectorListModel;
	import org.aswing.border.BevelBorder;
	
	public class ProjectView extends JWindow
	{
		public static const SEND_CLICKED:String = "VIEW_PROJECT_SEND_CLICKED";
		public static const EXIT_CLICKED:String = "VIEW_PROJECT_EXIT_CLICKED";
		public static const FINISH_CLICKED:String = "VIEW_PROJECT_FINISH_CLICKED";
		public static const BAN_CLICKED:String = "VIEW_PROJECT_BAN_CLICKED";
		
		private var vct_participants:VectorListModel;
		
		private var _pro_state_tree_view:StateTreeView;
		
		private var txt_input:JTextArea;
		private var txt_output:JTextArea;
		
		private var btn_send_message:JButton;
		//private var btn_full_screen:JButton;
		private var btn_exit_project:JButton;
		private var btn_finish_project:JButton;
		private var btn_ban_user:JButton;
		private var lst_participants:JList;
		private var pnl_world_view:AssetPane;
		private var pnl_state_tree:AssetPane;
		
		private var _pro_world_view:WorldView;
		private var tlb_toolbar:JToolBar;
		
		private var pnl_text:JPanel;
		private var pnl_input:JPanel;
		private var pnl_top:JPanel;
		private var pnl_bottom:JPanel;
		
		private var _pao_user:User;
		
		private var pno_area_world:Sprite;
		
		public function ProjectView(world_view:WorldView, state_tree:StateTreeView)
		{
			
			getContentPane().setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS,0,SoftBoxLayout.CENTER));
			
			_pro_world_view = world_view;
			_pro_state_tree_view = state_tree;
			
			
			tlb_toolbar = new JToolBar();
			tlb_toolbar.setOrientation(AsWingConstants.VERTICAL);
			btn_send_message = new JButton("Send");
			btn_exit_project = new JButton("", new LoadIcon("exit.png"));
			btn_finish_project = new JButton("", new LoadIcon("finish.png"));
			//btn_full_screen = new JButton("", new LoadIcon("fullscreen.png"));
			btn_ban_user = new JButton("", new LoadIcon("ban_user.png"));
			btn_exit_project.setToolTipText("Exit");
			btn_finish_project.setToolTipText("Finish");
			//btn_full_screen.setToolTipText("FullScreen");
			btn_ban_user.setToolTipText("Ban User");

			
			//tlb_toolbar.append(btn_full_screen);
			tlb_toolbar.append(btn_exit_project);
			tlb_toolbar.append(btn_finish_project);
			tlb_toolbar.append(btn_ban_user);
			
			txt_output = new JTextArea("",10,40);
			txt_input = new JTextArea("",2,40);
			
			vct_participants = new VectorListModel();
			lst_participants = new JList(vct_participants);
			lst_participants.setVisibleCellWidth(200);
			lst_participants.setVisibleRowCount(5);
			lst_participants.setBorder(new BevelBorder());
			lst_participants.setBackground(new ASColor(0xffffff));
			vct_participants.append("oi");
			
			pno_area_world = new Sprite();
			pno_area_world.graphics.beginFill(0xffffff,0);
			pno_area_world.graphics.drawRect(0,0,1280,480);
			pno_area_world.graphics.endFill();
			pno_area_world.mouseChildren = false;
			pno_area_world.mouseEnabled = false;
			
			pnl_top = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.CENTER));
			pnl_bottom = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.CENTER));
			pnl_state_tree = new AssetPane(_pro_state_tree_view);
			pnl_world_view = new AssetPane(pno_area_world);
			pnl_text = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			
			pnl_input = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS));
			pnl_input.append(txt_input);
			pnl_input.append(btn_send_message);
			
			pnl_text.append(txt_output);
			pnl_text.append(pnl_input);
			
			
			trace(pnl_world_view.width,pnl_world_view.height);
			this.addChild(pro_world_view);
			pnl_top.append(pnl_world_view);
			pnl_top.append(tlb_toolbar);
			
			pnl_bottom.append(pnl_state_tree);
			pnl_bottom.append(pnl_text);
			pnl_bottom.append(lst_participants);
			
			getContentPane().append(pnl_top);
			getContentPane().append(pnl_bottom);
			pack();
			configureListeners();
		}
		public function configureListeners():void
		{
			NResponder.addNative(btn_exit_project, MouseEvent.CLICK, btn_exit_project_clicked_event);
			NResponder.addNative(btn_finish_project, MouseEvent.CLICK, btn_finish_project_clicked_event);
			//NResponder.addNative(btn_full_screen, MouseEvent.CLICK, btn_full_screen_clicked_event);
			NResponder.addNative(btn_send_message, MouseEvent.CLICK, btn_send_message_clicked_event);
			NResponder.addNative(btn_ban_user, MouseEvent.CLICK, btn_ban_user_clicked_event);
			NResponder.add(WorldView.WORLD_SIZE_MODIFIED, world_size_modified);
		}
		
		private function world_size_modified():void
		{
			pack();
		}
		
		private function btn_exit_project_clicked_event(e:MouseEvent):void
		{
			NResponder.dispatch(EXIT_CLICKED);
		}
		
		private function btn_finish_project_clicked_event(e:MouseEvent):void
		{
			NResponder.dispatch(FINISH_CLICKED);
		}
		
		/*private function btn_full_screen_clicked_event(e:MouseEvent):void
		{
			if(this.stage.displayState != StageDisplayState.NORMAL)
				this.stage.displayState = StageDisplayState.NORMAL;
			else
				this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			trace(pro_world_view.prl_view_3d[0].height);
		}*/
		
		private function btn_send_message_clicked_event(e:MouseEvent):void
		{
			output_add(pao_user.usr_name + ": " + txt_input.getText());
			NResponder.dispatch(SEND_CLICKED);
			input_clear();
		}
		private function btn_ban_user_clicked_event(e:MouseEvent):void
		{
			NResponder.dispatch(BAN_CLICKED);
		}
		public function input_clear():void
		{
			txt_input.setText("");	
		}
		
		public function output_clear():void
		{
			txt_output.setText("");
		}
		
		public function output_add(msg:String):void
		{
			txt_output.appendText(msg + "\n");
		}
		
		public function state_tree_add():void
		{
			
		}
		
		public function state_tree_remove():void
		{
			
		}
		
		public function state_tree_create():void
		{
			
		}
		
		/*public function show():void
		{
			AsWingManager.getStage().addChild(this);	
		}
		
		public function hide():void
		{
			AsWingManager.getStage().removeChild(this);	
		}*/

		public function get pro_state_tree_view():StateTreeView
		{
			return _pro_state_tree_view;
		}

		public function get pro_world_view():WorldView
		{
			return _pro_world_view;
		}

		public function get pao_user():User
		{
			return _pao_user;
		}

		public function set pao_user(value:User):void
		{
			_pao_user = value;
		}


	}
}