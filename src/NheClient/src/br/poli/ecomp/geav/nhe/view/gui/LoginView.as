package br.poli.ecomp.geav.nhe.view.gui
{
	import appkit.responders.NResponder;
	
	import org.aswing.AsWingConstants;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JTextField;
	import org.aswing.SoftBoxLayout;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	
	public class LoginView extends JFrame
	{
		public static const LOGIN_CLICKED:String = "LOGIN_CLICKED";
		
		private var txt_user:JTextField;
		private var txt_password:JTextField;
		private var lbl_user:JLabel;
		private var lbl_password:JLabel;
		
		private var btn_login:JButton;
		private var btn_clear:JButton;
		
		private var form:Form;
		
		private var row_user:FormRow;
		private var row_password:FormRow;
		private var row_buttons:FormRow;
		
		private var pnl_buttons:JPanel;
		
		/*-------------------------------------------------
		* 				 PUBLIC METHODS
		------------------------------------------------*/
		public function LoginView(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, title, modal);
			
			txt_user = new JTextField("",15);
			lbl_user = new JLabel("User:");
			lbl_user.setHorizontalAlignment(AsWingConstants.RIGHT);
			txt_password = new JTextField("",15);
			txt_password.setDisplayAsPassword(true);
			lbl_password = new JLabel("Password:");
			lbl_password.setHorizontalAlignment(AsWingConstants.RIGHT);
			
			form = new Form();
			row_buttons = new FormRow();
			row_user = new FormRow();
			row_password = new FormRow();
			
			btn_clear = new JButton("Clear");
			btn_login = new JButton("Login");
			
			row_buttons.setAlignmentX(0.5);
			
			pnl_buttons = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS,0,SoftBoxLayout.CENTER));
			pnl_buttons.setAlignmentX(0.5);
			
			row_password.append(lbl_password);
			row_password.append(txt_password);
			row_user.append(lbl_user);
			row_user.append(txt_user);
			row_buttons.append(pnl_buttons);
			
			row_user.setColumnChildrenIndecis("0,1");
			row_password.setColumnChildrenIndecis("0,1");
			row_buttons.setColumnChildrenIndecis("0,0");
			
			pnl_buttons.append(btn_login);
			pnl_buttons.append(btn_clear);
			
			form.append(row_user);
			form.append(row_password);
			form.append(row_buttons);
			
			getContentPane().append(form);
			
			pack();
			
			configureListeners();
			setDefaultButton(btn_login);
		}
		/*-------------------------------------------------
		* 					PROPERTIES
		------------------------------------------------*/
		public function get user():String
		{
			return txt_user.getText();
		}
		
		public function get password():String
		{
			return txt_password.getText();
		}
		
		/*-------------------------------------------------
		 * 				 PRIVATE METHODS
		 ------------------------------------------------*/
		
		private function configureListeners():void 
		{
			btn_login.addActionListener(btn_login_clicked);
		}
		
		private function btn_login_clicked(e:AWEvent):void
		{
			NResponder.dispatch(LOGIN_CLICKED);
		}
		
		public function clear():void
		{
			txt_password.setText("");
			txt_user.setText("");
		}
	}
}
