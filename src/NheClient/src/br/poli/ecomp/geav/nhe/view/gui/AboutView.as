package br.poli.ecomp.geav.nhe.view.gui
{
	import org.aswing.AsWingConstants;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.LoadIcon;
	import org.aswing.SoftBoxLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	
	public class AboutView extends JFrame
	{
		//members define
		private var lbl_picture:JLabel;
		private var lbl_text:JLabel;
		
		/**
		 * PainelTeste Constructor
		 */
		public function AboutView(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, title, modal);
			//component creation
			var painel:JPanel = new JPanel();
			
			setSize(new IntDimension(405, 200));
			painel.setSize(new IntDimension(405, 200));
			painel.setLayout(new SoftBoxLayout(AsWingConstants.HORIZONTAL,5,AsWingConstants.TOP));
			
			lbl_picture = new JLabel();
			lbl_picture.setSize(new IntDimension(100, 100));
			lbl_picture.setLocation(new IntPoint(5, 5));
			lbl_picture.setPreferredSize(new IntDimension(100, 100));
			lbl_picture.setIcon(new LoadIcon("face.jpg"));
			
			lbl_text = new JLabel();
			lbl_text.setText("\n\nSoftware Developed by \n" +
				"Anderson Carlos Moreira Tavares.\n" +
				"Email: acmt@ecomp.poli.br\n" +
				"\tatavares@pe.senai.br\n" +
				"MSc Student (PPGES)\n" +
				"2011 - POLI - UPE");
			lbl_text.setLocation(new IntPoint(10, 5));
			lbl_text.setSize(new IntDimension(300, 200));
			lbl_text.setHorizontalAlignment(AsWingConstants.LEFT);
			lbl_text.setVerticalAlignment(AsWingConstants.TOP);
			lbl_text.setPreferredSize(new IntDimension(300, 200));
			
			
			//component layoution
			painel.append(lbl_picture);
			painel.append(lbl_text);
			
			getContentPane().append(painel);
		}
	}
}