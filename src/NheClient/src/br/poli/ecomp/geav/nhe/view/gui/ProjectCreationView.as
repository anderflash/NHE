package br.poli.ecomp.geav.nhe.view.gui
{
	import appkit.responders.NResponder;
	
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import org.aswing.ASColor;
	import org.aswing.AsWingConstants;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JList;
	import org.aswing.JPanel;
	import org.aswing.JTextArea;
	import org.aswing.JTextField;
	import org.aswing.ListModel;
	import org.aswing.SoftBoxLayout;
	import org.aswing.VectorListModel;
	import org.aswing.border.BevelBorder;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	import org.aswing.geom.IntDimension;
	
	public class ProjectCreationView extends JFrame
	{
		public static const CANCEL_CLICKED:String = "CREATE_PROJECT_CANCEL_CLICKED";
		public static const SAVE_CLICKED:String = "CREATE_PROJECT_SAVE_CLICKED";
		
		private var vct_participants:VectorListModel;
		private var vct_not_participants:VectorListModel;
		
		private var _pro_reference:FileReference; 
		
		//members define
		private var frm_project_creation_view:Form;
		private var row_title:FormRow;
		private var lbl_title:JLabel;
		private var txt_title:JTextField;
		private var row_description:FormRow;
		private var lbl_description:JLabel;
		private var txt_description:JTextArea;
		private var row_model:FormRow;
		private var lbl_model:JLabel;
		private var pnl_model:JPanel;
		//private var lbl_model_path:JLabel;
		private var txt_model_path:JTextField;
		private var btn_select_file:JButton;
		private var row_participants:FormRow;
		private var pnl_participant_selection:JPanel;
		private var pnl_not_participants:JPanel;
		private var lbl_participants:JLabel;
		private var lst_not_participants:JList;
		private var pnl_participant_buttons:JPanel;
		private var btn_append:JButton;
		private var btn_remove:JButton;
		private var pnl_participants:JPanel;
		private var lbl_not_participants:JLabel;
		private var lst_participants:JList;
		private var row_buttons:FormRow;
		private var pnl_buttons:JPanel;
		private var btn_save:JButton;
		private var btn_cancel:JButton;
		
		public function ProjectCreationView(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, title, modal);
			
			vct_not_participants = new VectorListModel();
			vct_participants = new VectorListModel();
			
			//component creation
			getContentPane().setLayout(new SoftBoxLayout(AsWingConstants.VERTICAL));
			
			frm_project_creation_view = new Form();
			
			row_title = new FormRow();
			row_title.setColumnChildrenIndecis("-1,0,1,1");
			
			lbl_title = new JLabel("Title:");
			
			txt_title = new JTextField();
			txt_title.setColumns(30);
			
			row_description = new FormRow();
			row_description.setColumnChildrenIndecis("-1,0,1,1");
			
			lbl_description = new JLabel();
			lbl_description.setText("Description:");
			
			txt_description = new JTextArea();
			txt_description.setRows(3);
			txt_description.setColumns(30);
			
			row_model = new FormRow();
			row_model.setColumnChildrenIndecis("-1,0,1,1");
			
			lbl_model = new JLabel();
			lbl_model.setText("3D Model:");
			
			pnl_model = new JPanel();
			
			/*lbl_model_path = new JLabel();
			lbl_model_path.setPreferredSize(new IntDimension(180, 17));
			lbl_model_path.setText("Model Path:");*/
			
			txt_model_path = new JTextField();
			txt_model_path.setColumns(10);
			
			
			btn_select_file = new JButton();
			btn_select_file.setText("Select &File");
			
			row_participants = new FormRow();
			row_participants.setColumnChildrenIndecis("-1,0,0,0");
			
			pnl_participant_selection = new JPanel();
			pnl_participant_selection.setSize(new IntDimension(349, 197));
			
			pnl_participant_selection.setLayout(new FlowLayout(AsWingConstants.CENTER));
			
			pnl_not_participants = new JPanel();
			var layout3:SoftBoxLayout = new SoftBoxLayout();
			layout3.setAxis(AsWingConstants.VERTICAL);
			layout3.setAlign(AsWingConstants.CENTER);
			pnl_not_participants.setLayout(layout3);
			
			lbl_not_participants = new JLabel("NOT Participants");
			
			lst_not_participants = new JList(vct_not_participants);
			lst_not_participants.setPreferredCellWidthWhenNoCount(150);
			lst_not_participants.setVisibleCellWidth(150);
			lst_not_participants.setVisibleRowCount(10);
			lst_not_participants.setBackground(new ASColor(0xffffff));
			lst_not_participants.setBorder(new BevelBorder());
			
			pnl_participant_buttons = new JPanel();
			pnl_participant_buttons.setConstraints("Center");
			var layout4:SoftBoxLayout = new SoftBoxLayout();
			layout4.setAxis(AsWingConstants.VERTICAL);
			layout4.setAlign(AsWingConstants.CENTER);
			pnl_participant_buttons.setLayout(layout4);
			
			btn_append = new JButton();
			btn_append.setText(" > ");
			
			btn_remove = new JButton();
			btn_remove.setText(" < ");
			
			pnl_participants = new JPanel();
			var layout5:SoftBoxLayout = new SoftBoxLayout();
			layout5.setAxis(AsWingConstants.VERTICAL);
			layout5.setAlign(AsWingConstants.CENTER);
			pnl_participants.setLayout(layout5);
			
			lbl_participants = new JLabel();
			lbl_participants.setText("Participants");
			
			lst_participants = new JList(vct_participants);
			lst_participants.setPreferredCellWidthWhenNoCount(150);
			lst_participants.setVisibleCellWidth(150);
			lst_participants.setVisibleRowCount(10);
			lst_participants.setBorder(new BevelBorder());
			lst_participants.setBackground(new ASColor(0xffffff));
			
			row_buttons = new FormRow();
			row_buttons.setColumnChildrenIndecis("-1,0,1,2");
			
			pnl_buttons = new JPanel();
			
			btn_save = new JButton();
			btn_save.setText("&Save");
			
			btn_cancel = new JButton();
			btn_cancel.setText("&Cancel");
			
			//component layoution
			getContentPane().append(frm_project_creation_view);
			
			frm_project_creation_view.append(row_title);
			frm_project_creation_view.append(row_description);
			frm_project_creation_view.append(row_model);
			frm_project_creation_view.append(row_participants);
			frm_project_creation_view.append(row_buttons);
			
			row_title.append(lbl_title);
			row_title.append(txt_title);
			
			row_description.append(lbl_description);
			row_description.append(txt_description);
			
			row_model.append(lbl_model);
			row_model.append(pnl_model);
			
			pnl_model.append(txt_model_path);
			pnl_model.append(btn_select_file);
			
			row_participants.append(pnl_participant_selection);
			
			pnl_participant_selection.append(pnl_not_participants);
			pnl_participant_selection.append(pnl_participant_buttons);
			pnl_participant_selection.append(pnl_participants);
			
			pnl_not_participants.append(lbl_not_participants);
			pnl_not_participants.append(lst_not_participants);
			
			pnl_participant_buttons.append(btn_append);
			pnl_participant_buttons.append(btn_remove);
			
			pnl_participants.append(lbl_participants);
			pnl_participants.append(lst_participants);
			
			row_buttons.append(pnl_buttons);
			
			pnl_buttons.append(btn_save);
			pnl_buttons.append(btn_cancel);
			
			
			configureListeners();
			pack();
			
			btn_append_update();
			btn_remove_update();
		}
		
		public function get pro_reference():FileReference
		{
			return _pro_reference;
		}

		private function configureListeners():void
		{
			btn_select_file.addEventListener(MouseEvent.CLICK, btn_select_file_clicked_event);
			btn_append.addEventListener(MouseEvent.CLICK, btn_append_clicked_event);
			btn_remove.addEventListener(MouseEvent.CLICK, btn_remove_clicked_event);
			btn_save.addEventListener(MouseEvent.CLICK, btn_save_clicked_event);
			btn_cancel.addEventListener(MouseEvent.CLICK, btn_cancel_clicked_event);
		}
		
		private function btn_select_file_clicked_event(e:MouseEvent):void
		{
			if(_pro_reference == null)
				_pro_reference = new FileReference();
			var fileFilterModels:FileFilter = new FileFilter("3D Models","*.3ds;*.dae;*.obj;*.md2;*.md5");
			var fileFilterZip:FileFilter = new FileFilter("Zipped Models","*.zip");
			_pro_reference.browse([fileFilterZip,fileFilterModels]);
		}
		
		private function btn_append_clicked_event(e:MouseEvent):void
		{
			var obj:* = lst_not_participants.getSelectedValue();
			vct_participants.append(obj);
			vct_not_participants.remove(obj);
			btn_append_update();
			btn_remove_update();
		}
		
		private function btn_remove_clicked_event(e:MouseEvent):void
		{
			var obj:* = lst_participants.getSelectedValue();
			vct_not_participants.append(obj);
			vct_participants.remove(obj);
			btn_append_update();
			btn_remove_update();
		}
		
		private function btn_save_clicked_event(e:MouseEvent):void
		{
			NResponder.dispatch(SAVE_CLICKED);
		}
		
		private function btn_cancel_clicked_event(e:MouseEvent):void
		{
			NResponder.dispatch(CANCEL_CLICKED);
		}
		
		public function clear():void
		{
			
		}
		
		private function btn_append_update():void
		{
			if(lst_not_participants.getSelectedIndex() == -1)
				btn_append.setEnabled(false);
			else
				btn_append.setEnabled(true);
		}
		
		private function btn_remove_update():void
		{
			if(lst_participants.getSelectedIndex() == -1)
				btn_remove.setEnabled(false);
			else
				btn_remove.setEnabled(true);
		}
		
		public function get project_title():String
		{
			return txt_title.getText();
		}
		public function get project_description():String
		{
			return txt_description.getText();
		}
		public function get project_model_file():String
		{
			return txt_model_path.getText();
		}
		
		public function get project_participants():Array
		{
			return vct_participants.toArray();
		}
		
		public function participant_add(non_participant:Boolean = true):void{}
		public function participant_remove():void{}
	}
}