package controller.state
{
	import view.state.StateTreeView;

	public class StateTreeController
	{
		private var _prl_state_controllers:Vector.<StateController>;
		
		private var _pao_state_tree_widget:StateTreeView;
		
		public function StateTreeController()
		{
			this._prl_state_controllers = new Vector.<StateController>();
		}

		public function get pao_state_tree_widget():StateTreeView
		{
			return _pao_state_tree_widget;
		}

		public function set pao_state_tree_widget(value:StateTreeView):void
		{
			_pao_state_tree_widget = value;
		}

		public function get prl_state_controllers():Vector.<StateController>
		{
			return _prl_state_controllers;
		}
	}
}