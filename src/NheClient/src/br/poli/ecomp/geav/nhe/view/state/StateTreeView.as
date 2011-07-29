package br.poli.ecomp.geav.nhe.view.state
{
	import appkit.responders.NResponder;
	
	import flash.debugger.enterDebugger;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public class StateTreeView extends Sprite
	{
		public static const STATEVIEW_CLICKED:String = "STATEVIEW_CLICKED";
		
		private var _view_width:Number;
		private var _view_height:Number;
		
		private var _pro_current_state:StateView;
		private var _pro_old_state:StateView;
		
		private var background_sprite:Sprite;
		private var mask_sprite:Sprite;
		private var line_sprite:Sprite;
		private var state_tree_sprite:Sprite;
		
		private var _pro_state_root:StateView;
		
		/*-------------------------------------------
		* 			    PUBLIC METHODS
		--------------------------------------------*/
		public function StateTreeView(view_width:Number, view_height:Number)
		{
			super();
			this._view_height = view_height;
			this._view_width = view_width;
			
			create_background();
			create_mask();
			
			create_tree_sprite();
			create_line_sprite();
			
			addEventListener(MouseEvent.MOUSE_DOWN, state_tree_mouse_down);
			addEventListener(MouseEvent.MOUSE_UP, state_tree_mouse_up);
		}
		
		public function draw():void
		{
			line_sprite.graphics.clear();
			removeChildren();
			addChild(background_sprite);
			trace(background_sprite.height);
			addChild(state_tree_sprite);
			state_tree_sprite.addChild(pro_state_root);
			
			var sizeX:Number = pro_state_root.width;
			var sizeY:Number = pro_state_root.height;
			
			var spaceX:Number = 30;
			var spaceY:Number = 2;
			
			pro_state_root.x = pro_state_root.width + depth * (pro_state_root.width + sizeX);
			pro_state_root.y = (height - pro_state_root.height)/2;
			
			var depth:Number = 0;

			var hasChild:Boolean = _pro_state_root.prl_children.length > 0;
			
			// Draw States
			while(hasChild)
			{
				hasChild = false;
				var vectorDepth:Vector.<StateView> = pro_state_root.depth_vector(depth);
				var initialPosY:Number = (height - (vectorDepth.length * sizeY + (vectorDepth.length-1) * spaceY))/2; 
				for(var i:uint = 0; i < vectorDepth.length; i++)
				{
					state_tree_sprite.addChild(vectorDepth[i]);
					vectorDepth[i].buttonMode = true;
					NResponder.addNative(vectorDepth[i],MouseEvent.CLICK, state_clicked_event);
					vectorDepth[i].x = sizeX + depth * (sizeX + spaceX);
					vectorDepth[i].y = initialPosY;
					initialPosY += vectorDepth[i].height + spaceY;
					if(vectorDepth[i].prl_children.length > 0) hasChild = true;
				}
				depth++;
			}
			
			// Draw Connections
			drawLineChildren(pro_state_root);
		}
		
		
		
		
		/*-------------------------------------------
		* 			    PROPERTIES
		--------------------------------------------*/
		
		public function get view_width():Number
		{
			return _view_width;
		}
		
		public function set view_width(value:Number):void
		{
			_view_width = value;
		}
		
		public function get view_height():Number
		{
			return _view_height;
		}
		
		public function set view_height(value:Number):void
		{
			_view_height = value;
		}
		override public function get width():Number
		{
			return background_sprite.width;
		}
		
		override public function get height():Number
		{
			return background_sprite.height;
		}
		
		public function get pro_state_root():StateView
		{
			return _pro_state_root;
		}
		
		public function set pro_state_root(value:StateView):void
		{
			_pro_state_root = value;
			
		}
		
		/*-------------------------------------------
		* 			    PRIVATE METHODS
		--------------------------------------------*/
		private function create_background():void
		{
			background_sprite = new Sprite();
			background_sprite.graphics.beginFill(0xffffff);
			background_sprite.graphics.lineStyle(1,0x00aa00);
			background_sprite.graphics.drawRoundRect(0,0,_view_width,_view_height,20,20);
			background_sprite.graphics.endFill();
			addChild(background_sprite);
			
			NResponder.addNative(background_sprite, MouseEvent.MOUSE_OUT, background_mouse_out);
		}
		private function create_mask():void
		{
			mask_sprite = new Sprite();
			mask_sprite.graphics.beginFill(0xffffff);
			mask_sprite.graphics.drawRoundRect(1,1,_view_width-1,_view_height-1,20,20);
			mask_sprite.graphics.endFill();
		}
		
		private function create_tree_sprite():void
		{
			state_tree_sprite = new Sprite();
			state_tree_sprite.mask = mask_sprite;
			addChild(state_tree_sprite);
		}
		
		private function create_line_sprite():void
		{
			line_sprite = new Sprite();
			state_tree_sprite.addChildAt(line_sprite,0);
		}
		
		private function state_clicked_event(e:MouseEvent):void
		{
			if(pro_current_state)
				pro_current_state.highlight(false);
			_pro_old_state = pro_current_state;
			_pro_current_state = StateView(e.currentTarget);
			pro_current_state.highlight(true);
			NResponder.dispatch(STATEVIEW_CLICKED);
		}
		
		private function drawLineChildren(state:StateView):void
		{
			for(var i:uint = 0 ; i < state.prl_children.length; i++)
			{
				line_sprite.graphics.lineStyle(1,0x00aa00);
				line_sprite.graphics.moveTo(state.x + state.width/2, state.y + state.height/2);
				line_sprite.graphics.lineTo(state.prl_children[i].x + state.prl_children[i].width/2, state.prl_children[i].y + state.prl_children[i].height/2);
				drawLineChildren(state.prl_children[i]);
			}
		}
		
		private function state_tree_mouse_down(e:MouseEvent):void
		{
			state_tree_sprite.startDrag();
			
		}
		
		private function state_tree_mouse_up(e:MouseEvent):void
		{
			state_tree_sprite.stopDrag();
		}
		
		
		private function background_mouse_out(e:MouseEvent):void
		{
			state_tree_mouse_up(e);
		}

		public function get pro_current_state():StateView
		{
			return _pro_current_state;
		}

		public function get pro_old_state():StateView
		{
			return _pro_old_state;
		}
	}
}