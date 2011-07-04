package br.poli.ecomp.geav.nhe
{
	import br.poli.ecomp.geav.nhe.view.gui.ProjectView;
	import br.poli.ecomp.geav.nhe.view.state.StateTreeView;
	import br.poli.ecomp.geav.nhe.view.world.WorldView;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import org.aswing.AsWingManager;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.JWindow;
	
	public class TestJPanel extends Sprite
	{
		public function TestJPanel()
		{
			AsWingManager.initAsStandard(stage);
			var projview:ProjectView = new ProjectView(new WorldView(), new StateTreeView(300,110));
			projview.show();
		}
	}
}