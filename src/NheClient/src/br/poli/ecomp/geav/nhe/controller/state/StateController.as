package br.poli.ecomp.geav.nhe.controller.state
{
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.controller.world.WorldController;
	import br.poli.ecomp.geav.nhe.model.state.State;
	import br.poli.ecomp.geav.nhe.view.state.StateTreeView;
	import br.poli.ecomp.geav.nhe.view.state.StateView;

	public class StateController
	{
		private var _pro_state_tree_view:StateTreeView;
		
		private var pro_state_root:State;
		private var _pao_world_controller:WorldController;
		
		/*----------------------------------
		 * 			PUBLIC METHODS
		 ---------------------------------*/
		public function StateController()
		{
			_pro_state_tree_view = new StateTreeView(300,100);
			NResponder.add(StateTreeView.STATEVIEW_CLICKED, state_tree_clicked_handler);
		}

		/*----------------------------------
		* 			PROPERTIES
		---------------------------------*/
		public function get pro_state_tree_view():StateTreeView
		{
			return _pro_state_tree_view;
		}
		
		
		
		/*----------------------------------
		* 		   PRIVATE METHODS
		---------------------------------*/
		private function state_tree_clicked_handler(stateview:StateView):void
		{
			var route:Vector.<Vector.<StateView>> = find_route(pro_state_tree_view.pro_old_state, pro_state_tree_view.pro_current_state);
			
			var route_undo:Vector.<StateView> = route[0];
			var route_do:Vector.<StateView> = route[1];
			
			for(var i:uint = 0; i < route_undo.length; i++)
			{
				pao_world_controller.action_undo((stateview.pao_model as State).pao_action);
			}
			
			for(i = 0; i < route_do.length; i++)
			{
				pao_world_controller.action_do((stateview.pao_model as State).pao_action);
			}
		}
		
		private function find_route(state1:StateView, state2:StateView):Vector.<Vector.<StateView>>
		{
			var cur_state1:StateView = state1;
			var cur_state2:StateView = state2;
			var lista_do:Vector.<StateView> = new Vector.<StateView>();
			var lista_undo:Vector.<StateView> = new Vector.<StateView>();
			
			var lista:Vector.<Vector.<StateView>> = new Vector.<Vector.<StateView>>();
			lista.push(lista_undo);
			lista.push(lista_do);
			var inicio:Number = 0;
			var fim:Number = 0;
			
			while(cur_state1 != cur_state2)
			{
				var depth1:Number = cur_state1.prn_depth;
				var depth2:Number = cur_state2.prn_depth;
				
				if(cur_state1.prn_depth >= depth2)
				{
					lista_undo.push(cur_state1);
					cur_state1 = cur_state1.pro_parent;
				}
				
				if(cur_state2.prn_depth >= depth1)
				{
					lista_do.unshift(cur_state2);
					cur_state2 = cur_state2.pro_parent;
				}
			}
			return lista;
		}

		public function get pao_world_controller():WorldController
		{
			return _pao_world_controller;
		}

		public function set pao_world_controller(value:WorldController):void
		{
			_pao_world_controller = value;
		}

	}
}