package br.poli.ecomp.geav.nhe
{
	import br.poli.ecomp.geav.nhe.view.gui.ProjectView;
	import br.poli.ecomp.geav.nhe.view.state.StateTreeView;
	import br.poli.ecomp.geav.nhe.view.state.StateView;
	import br.poli.ecomp.geav.nhe.view.world.WorldView;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import org.aswing.AsWingManager;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.JWindow;
	
	public class TestStateTree extends Sprite
	{
		public function TestStateTree()
		{
			AsWingManager.initAsStandard(stage);
			var view:StateTreeView = new StateTreeView(300,100);
			addChild(view);
			
			var stateview:StateView = new StateView();
			stateview.message = "Adicionou Bloco 1";
			stateview.label = "A1";
			
			view.pro_state_root = stateview;
			
			
			
			var state1:StateView = new StateView();
			var state2:StateView = new StateView();
			var state3:StateView = new StateView();
			var state4:StateView = new StateView();
			var state5:StateView = new StateView();
			state1.message = "Moveu Bloco 1";
			state2.message = "Removeu Bloco 1";
			state3.message = "Adicionou Bloco 2";
			state4.message = "Adicionou Bloco 3";
			state5.message = "Adicionou Bloco 3";
			state1.label= "M1";
			state2.label= "D1";
			state3.label= "A2";
			state4.label= "A3";
			state5.label= "A4";
			stateview.addStateChild(state5);
			stateview.addStateChild(state1);
			stateview.addStateChild(state2);
			state1.addStateChild(state3);
			state3.addStateChild(state4);
			view.draw();
		}
	}
}