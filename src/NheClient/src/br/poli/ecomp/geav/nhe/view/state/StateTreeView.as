package br.poli.ecomp.geav.nhe.view.state
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.core.mx_internal;
	
	public class StateTreeView extends Sprite
	{
		private var state_root:StateView;
		
		private var _view_width:Number;
		private var _view_height:Number;
		
		private var current_state:StateView;
		
		private var background_sprite:Sprite;
		private var mask_sprite:Sprite;
		private var state_tree_sprite:Sprite;
		
		public function StateTreeView(view_width:Number, view_height:Number)
		{
			super();
			this._view_height = view_height;
			this._view_width = view_width;
			
			create_background();
			create_mask();
			create_tree_sprite();
			
			addEventListener(MouseEvent.MOUSE_DOWN, state_tree_mouse_down);
			addEventListener(MouseEvent.MOUSE_UP, state_tree_mouse_up);
		}
		
		private function create_background():void
		{
			background_sprite = new Sprite();
			background_sprite.graphics.beginFill(0xffffff);
			background_sprite.graphics.lineStyle(1,0x00aa00);
			background_sprite.graphics.drawRoundRect(0,0,_view_width,_view_height,20,20);
			background_sprite.graphics.endFill();
			addChild(background_sprite);
		}
		private function create_mask():void
		{
			background_sprite = new Sprite();
			background_sprite.graphics.beginFill(0xffffff);
			background_sprite.graphics.drawRoundRect(0,0,_view_width-1,_view_height-1,20,20);
			background_sprite.graphics.endFill();
		}
		
		private function create_tree_sprite():void
		{
			state_tree_sprite = new Sprite();
			state_tree_sprite.mask = mask_sprite;
			addChild(state_tree_sprite);
		}

		
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

		private function state_tree_mouse_down(e:MouseEvent):void
		{
			state_tree_sprite.startDrag();
		}
		
		private function state_tree_mouse_up(e:MouseEvent):void
		{
			state_tree_sprite.stopDrag();
		}
		
		override public function get width():Number
		{
			return background_sprite.width;
		}
		
		override public function get height():Number
		{
			return background_sprite.height;
		}
		
		
	}
}