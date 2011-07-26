package br.poli.ecomp.geav.nhe.view.state
{
	import appkit.responders.NResponder;
	
	import br.poli.ecomp.geav.nhe.model.errors.StateError;
	import br.poli.ecomp.geav.nhe.model.state.State;
	import br.poli.ecomp.geav.nhe.view.util.ITooltipavel;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class StateView extends Sprite implements ITooltipavel
	{
		private var tf_label:TextField;
		
		private var tf_message:TextField;
		
		private var _label:String;
		private var _message:String;
		private var prb_show_tooltip:Boolean;
		
		private var _prl_children:Vector.<StateView>;
		private var _pro_parent:StateView;
		
		public static const STATEVIEW_ADDED:String = "STATEVIEW_ADDED";
		public static const STATEVIEW_REMOVED:String = "STATEVIEW_REMOVED";
		
		private var _pao_model:Object;
		
		private var _prn_depth:Number;
		
		/* ---------------------------------------
		 * 			   PUBLIC METHODS
		 * --------------------------------------- */
		public function StateView()
		{
			super();
			tf_label = new TextField();
			tf_label.background = true;
			tf_label.backgroundColor = 0xffffff;
			tf_label.border = true;
			tf_label.selectable = false;
			tf_label.borderColor = 0x00aa00;
			tf_label.autoSize = TextFieldAutoSize.LEFT;
			addChild(tf_label);
			//mouseChildren = false;
			tf_label.addEventListener(MouseEvent.MOUSE_OVER, statewidget_mouse_over_event);
			tf_label.addEventListener(MouseEvent.MOUSE_OUT, statewidget_mouse_out_event);
			tf_label.addEventListener(MouseEvent.MOUSE_MOVE, statewidget_mouse_move_event);
			
			
			tf_message = new TextField();
			tf_message.background = true;
			tf_message.backgroundColor = 0xcccccc;
			tf_message.mouseEnabled = false;
			tf_message.autoSize = TextFieldAutoSize.LEFT;
			
			tooltip_enable();
			
			_prl_children = new Vector.<StateView>();
			_prn_depth = 0;
		}
		
		
		public function tooltip_enable():void
		{
			prb_show_tooltip = true;
		}
		
		public function tooltip_disable():void
		{
			prb_show_tooltip = false;			
		}
		
		public function addStateChild(stateview:StateView):void
		{
			
			if(prl_children.indexOf(stateview) != -1)
				prl_children.splice(prl_children.indexOf(stateview),1);
			prl_children.push(stateview);
			stateview._pro_parent = this;
			stateview._prn_depth = _prn_depth + 1;
			NResponder.dispatch(STATEVIEW_ADDED, [this]);
		}
		
		public function addStateChildAt(stateview:StateView, pos:Number):void
		{
			if(prl_children.indexOf(stateview) != -1)
				prl_children.splice(prl_children.indexOf(stateview),1);
			prl_children.splice(pos,0,stateview);
			stateview._pro_parent = this;
			stateview._prn_depth = _prn_depth + 1;
			NResponder.dispatch(STATEVIEW_ADDED, [this]);
		}
		
		public function removeStateChild(stateview:StateView):StateView
		{
			if(prl_children.indexOf(stateview) != -1)
				prl_children.splice(prl_children.indexOf(stateview),1);
			stateview._pro_parent = null;
			
			NResponder.dispatch(STATEVIEW_REMOVED, [this]);
			return stateview;
		}
		
		public function removeStateChildAt(index:Number):StateView
		{
			if(index >= _prl_children.length) throw new StateError(StateError.BEYOND_RANGE_ERROR, "The index is beyond the range");
			else
			{
				var child:StateView = _prl_children[index];
				_prl_children.splice(index,1);
				child._pro_parent = null;
			}
			NResponder.dispatch(STATEVIEW_REMOVED, [this]);
			return child;
		}
		
		public function clone(deep:Boolean = false):StateView
		{
			var newState:StateView = new StateView();
			newState._label = _label;
			newState._message = _message;
			newState._prn_depth = _prn_depth;
			
			if(deep)
			{
				for(var i:uint = 0; i < _prl_children.length; i++)
				{
					newState.addStateChild(_prl_children[i].clone(deep));
				}
			}
			else
			{
				for(i = 0; i < _prl_children.length; i++)
				{
					newState.addStateChild(_prl_children[i]);
				}
			}
			
			return newState;
		}
		
		public function isAncestor(ancestor:StateView):Boolean
		{
			var stateTmp:StateView = this;
			while(stateTmp.pro_parent != null)
			{
				if(stateTmp.pro_parent == ancestor)
					return true;
				else
					stateTmp = stateTmp.pro_parent;
			}
			return false;
		}
		
		public function isDescendent(descedent:StateView):Boolean
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
		
		public function depthFromAncestor(ancestor:StateView):Number
		{
			var level:Number = 0;
			var stateTmp:StateView = this;
			while(stateTmp.pro_parent != null)
			{
				level++;
				if(stateTmp.pro_parent == ancestor) return level;
				stateTmp = stateTmp.pro_parent;
			}
			throw new StateError(StateError.NOT_ANCESTOR_ERROR, "You can't calculate depth if the parameter is not ancestor");
		}
		
		public function depth_vector(depth:Number):Vector.<StateView>
		{
			var vector_state_depth:Vector.<StateView> = new Vector.<StateView>();
			
			var handler:Function = function(state:StateView, depth2:Number):void
			{
				if(depth2 == depth)
					vector_state_depth.push(state);
				else
				{
					for(var i:uint = 0; i < state.prl_children.length; i++)
					{
						handler(state.prl_children[i], depth2+1); 
					}
				}
			};
			
			handler(this.pro_root, 0);
			return vector_state_depth;
		}
		
		public function highlight(enable:Boolean):void
		{
			tf_label.background = true;
			if(enable)
			{
				tf_label.backgroundColor = 0xff8888;
			}
			else
			{
				tf_label.backgroundColor = 0xffffff;
			}
					
		}
		
		/* ---------------------------------------
		* 			   PROPERTIES
		* --------------------------------------- */
		/**
		 * Gets/Sets the label text of the state 
		 * @return 
		 * 
		 */
		public function get label():String
		{
			return _label;
		}
		
		/**
		 * @private
		 */
		public function set label(value:String):void
		{
			_label = value;
			tf_label.text = value;
		}
		
		/**
		 * Gets/Sets the tooltip message
		 * @return 
		 * 
		 */
		public function get message():String
		{
			return _message;
		}
		
		/**
		 * @private
		 */
		public function set message(value:String):void
		{
			_message = value;
			tf_message.text = value;
		}
		
		public function get prn_depth():Number
		{
			return _prn_depth;
		}
		
		public function get pro_root():StateView
		{
			var stateTmp:StateView = this;
			while(stateTmp.pro_parent != null)
			{
				stateTmp = stateTmp.pro_parent;
			}
			return stateTmp;
		}
		
		public function get pro_parent():StateView
		{
			return _pro_parent;
		}
		
		public function get prl_children():Vector.<StateView>
		{
			return _prl_children;
		}
		
		/* ---------------------------------------
		* 			  PRIVATE METHODS
		* --------------------------------------- */
		/**
		 * Show the tooltip if the mouse is over the state  
		 * @param e
		 * 
		 */
		private function statewidget_mouse_over_event(e:MouseEvent):void
		{
			if(prb_show_tooltip)
				stage.addChild(tf_message);
		}
		
		/**
		 * Remove the tooltip if the mouse is out of the state 
		 * @param e
		 */
		private function statewidget_mouse_out_event(e:MouseEvent):void
		{
			if(tf_message.parent)
				stage.removeChild(tf_message);
		}
		
		/**
		 * If the mouse is moving over the state widget,
		 * place the tooltip always above and near the mouse 
		 * @param e
		 * 
		 */
		private function statewidget_mouse_move_event(e:MouseEvent):void
		{
			var globalPoint:Point = new Point(mouseX, mouseY);
			tf_message.x = localToGlobal(globalPoint).x;
			tf_message.y = localToGlobal(globalPoint).y - tf_message.height;
			//var globalPoint:Point = localToGlobal(new Point(tf_message.x, tf_message.y));
			if(tf_message.y < 0)
				tf_message.y = 0;
			if(tf_message.y + tf_message.height > stage.stageHeight)
				tf_message.y = stage.stageHeight - tf_message.height;
			if(tf_message.x < 0)
				tf_message.x = 0;
			if(tf_message.x + tf_message.width > stage.stageWidth)
				tf_message.x = stage.stageWidth - tf_message.width;
		}

		public function get pao_model():Object
		{
			return _pao_model;
		}

		public function set pao_model(value:Object):void
		{
			_pao_model = value;
		}

	}
}