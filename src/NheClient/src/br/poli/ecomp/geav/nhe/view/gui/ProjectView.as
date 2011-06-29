package br.poli.ecomp.geav.nhe.view.gui
{
	import br.poli.ecomp.geav.nhe.view.augmentedreality.ARView;
	
	import org.aswing.JFrame;
	import org.aswing.JList;
	import org.aswing.JPanel;
	import org.aswing.JTextArea;
	import org.aswing.VectorListModel;
	
	public class ProjectView extends JFrame
	{
		private var vct_participants:VectorListModel;
		
		private var txt_input:JTextArea;
		private var txt_output:JTextArea;
		private var lst_participants:JList;
		private var pnl_ar_mine:JPanel;
		private var pnl_ar_owner:JPanel;
		
		private var ar_view:ARView;
		
		public function ProjectView(owner:*=null, title:String="", modal:Boolean=false)
		{
			
			txt_input:JTextArea;
			txt_output:JTextArea;
			lst_participants:JList;
			pnl_ar_mine:JPanel;
			pnl_ar_owner:JPanel;
			
			super(owner, title, modal);
		}
	}
}