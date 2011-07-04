package br.poli.ecomp.geav.nhe.controller.state
{
	import br.poli.ecomp.geav.nhe.view.state.StateTreeView;

	public class StateTreeController
	{
		private var _prl_state_controllers:Vector.<StateController>;
		
		private var _pao_state_tree_view:StateTreeView;
		
		public function StateTreeController()
		{
			this._prl_state_controllers = new Vector.<StateController>();
			_pao_state_tree_view = new StateTreeView(640,190);
		}

		public function get pao_state_tree_view():StateTreeView
		{
			return _pao_state_tree_view;
		}

		public function set pao_state_tree_view(value:StateTreeView):void
		{
			_pao_state_tree_view = value;
		}

		public function get prl_state_controllers():Vector.<StateController>
		{
			return _prl_state_controllers;
		}
	}
}