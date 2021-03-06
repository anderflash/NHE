package br.poli.ecomp.geav.nhe.model.state
{
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.errors.StateError;

	
	[Event(name="added", type="br.poli.ecomp.geav.nhe.model.state.State")]
	[Event(name="removed", type="br.poli.ecomp.geav.nhe.model.state.State")]
	[Event(name="action_changed", type="br.poli.ecomp.geav.nhe.model.state.State")]
	
	public class State
	{
		public static const REMOVED:String = "REMOVED";
		public static const ADDED:String = "ADDED";
		public static const ACTION_CHANGED:String = "ACTION_CHANGED";
		
		private var _pro_parent:State;
		private var _prl_children:Vector.<State>;
		private var _pao_action:Action;
		
		
		/*-------------------------------------------
		 * 				PUBLIC METHODS
		 --------------------------------------------*/
		public function State()
		{
			_prl_children = new Vector.<State>();
		}
		
		/**
		 * Add the child to the end of state list.
		 * @param child
		 * @event StateEvent.ADDED
		 */
		public function addChild(child:State):void
		{
			if(_prl_children.indexOf(child) != -1)
			{
				_prl_children.splice(_prl_children.indexOf(child),1);
			}
			_prl_children.push(child);
			child.pro_parent = this;
		}
		
		/**
		 * Add a Child at a specific index
		 * @param index
		 * @event StateEvent.ADDED
		 * 
		 */
		public function addChildAt(child:State, index:Number):void
		{
			if(_prl_children.indexOf(child) != -1)
				_prl_children.splice(_prl_children.indexOf(child),1);
			_prl_children.splice(index,0,child);
			child.pro_parent = this;
		}
		
		/**
		 * Remove a Child at a specific index 
		 * @param index
		 * @throws StateError with type StateError.BEYOND_RANGE_ERROR
		 * 
		 */
		public function removeChildAt(index:Number):State
		{
			if(index >= _prl_children.length) throw new StateError(StateError.BEYOND_RANGE_ERROR, "The index is beyond the range");
			else
			{
				var child:State = _prl_children[index];
				_prl_children.splice(index,1);
				child.pro_parent = null;
			}
			return child;
		}
		
		/**
		 * Remove a child state from the list of states 
		 * @param child
		 * 
		 */
		public function removeChild(child:State):State
		{
			if(_prl_children.indexOf(child) == -1) throw new StateError(StateError.NOT_CHILD_ERROR, "The parameter is not child of this state");
			else
			{
				var state:State = _prl_children.splice(_prl_children.indexOf(child),1)[0];
				state.pro_parent = null;
			}
			return state;
		}
		
		/**
		 * Clone the state. If deep is true, clone all the children and so on...
		 * @param deep a Boolean value. If true, clone all the children. If false, keep linking to the same children. 
		 * @return a new state with same attributes. If <code>deep</code> is <code>true</code>, clone the children in depth
		 * 
		 * 
		 */
		public function clone(deep:Boolean = false):State
		{
			var newState:State = new State();
			newState._pao_action = pao_action;
			
			if(deep)
			{
				for(var i:uint = 0; i < _prl_children.length; i++)
				{
					newState._prl_children.push(_prl_children[i].clone(true));
				}
			}
			else
			{
				for(i = 0; i < _prl_children.length; i++)
				{
					newState._prl_children.push(_prl_children[i]);
				}
			}
			return newState;
		}
		
		/**
		 * Asks if the parameter is a parent or grandfather or other ancestor 
		 * @param state
		 * @return true if the parameter ancestor is really a ancestor of the state 
		 * 
		 */
		public function isAncestor(ancestor:State):Boolean
		{
			var stateTmp:State = this;
			while(stateTmp.parent != null)
			{
				if(stateTmp.parent == ancestor)
					return true;
				else
					stateTmp = stateTmp.parent;
			}
			return false;
		}
		
		public function isDescendent(descedent:State):Boolean
		{
			if(_prl_children.length == 0) return false;
			else if(_prl_children.indexOf(descedent) != -1) return true;
			else
			{
				for(var i:uint = 0; i < _prl_children.length; i++)
				{
					if(_prl_children[i].isDescendent(descedent)) return true;
				}
				return false;
			}
		}
		/**
		 * Returns the level based on a ancestor (can be root or not)
		 * @param ancestor
		 * @return 
		 * @throws StateError.NOT_ANCESTOR_ERROR
		 */
		public function depthFromAncestor(ancestor:State):Number
		{
			var level:Number = 0;
			var stateTmp:State = this;
			while(stateTmp.parent != null)
			{
				level++;
				if(stateTmp.parent == ancestor) return level;
				stateTmp = stateTmp.parent;
			}
			throw new StateError(StateError.NOT_ANCESTOR_ERROR, "You can't calculate depth if the parameter is not ancestor");
		}
		/**
		 * Search a child (or other descendant) which has the action parameter
		 * @param action
		 * @return 
		 * 
		 */
		public function searchFromAction(action:Action):State
		{
			if(pao_action == action) return this;
			else
			{
				for(var i:uint = 0; i < _prl_children.length; i++)
				{
					var actionChild:State = _prl_children[i].searchFromAction(action);
					if(actionChild != null) return actionChild; 
				}
				return null;
			}
		}
		
		/*-------------------------------------------
		* 				  PROPERTIES
		--------------------------------------------*/
		/**
		 * Return the level of the state, relative to the root state
		 * (root has depth = 0) 
		 * @return the level of the state, from 0 to N 
		 */
		public function get prn_depth():Number
		{
			var level:Number = 0;
			var stateTmp:State = this;
			while(stateTmp.parent != null)
			{
				level++;
				stateTmp = stateTmp.parent;
			}
			return level;
		}
		
		/**
		 * Get the root of this state
		 * @return 
		 * 
		 */
		public function get pro_root():State
		{
			var stateTmp:State = this;
			while(stateTmp.parent != null)
			{
				stateTmp = stateTmp.parent;
			}
			return stateTmp;
		}
		
		/**
		 * Returns the state parent 
		 * @return 
		 * 
		 */
		public function get parent():State
		{
			return this.pro_parent;
		}
		
		/**
		 * Returns the number of children added to the state 
		 * @return 
		 * 
		 */
		public function get prn_num_children():Number
		{
			return _prl_children.length;
		}
		
		/**
		 * Get the action linked to this state 
		 * @return 
		 * 
		 */
		public function get pao_action():Action
		{
			return _pao_action;
		}
		
		public function get prl_children():Vector.<State>
		{
			return _prl_children;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set pao_action(value:Action):void
		{
			_pao_action = value;
			NResponder.dispatch(ACTION_CHANGED,[this]);
		}
		
		public function get pro_parent():State
		{
			return _pro_parent;
		}
		
		public function set pro_parent(value:State):void
		{
			_pro_parent = value;
			if(value != null)
				NResponder.dispatch(ADDED,[this]);
			else
				NResponder.dispatch(REMOVED,[this]);
		}
	}
}