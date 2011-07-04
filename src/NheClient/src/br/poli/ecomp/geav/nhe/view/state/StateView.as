package br.poli.ecomp.geav.nhe.view.state
{
	import br.poli.ecomp.geav.nhe.view.util.ITooltipavel;
	
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
		
		public function StateView()
		{
			super();
			tf_label = new TextField();
			tf_label.background = true;
			tf_label.backgroundColor = 0xffffff;
			tf_label.border = true;
			tf_label.borderColor = 0x00aa00;
			tf_label.autoSize = TextFieldAutoSize.LEFT;
			addChild(tf_label);
			mouseChildren = false;
			addEventListener(MouseEvent.MOUSE_OVER, statewidget_mouse_over_event);
			addEventListener(MouseEvent.MOUSE_OUT, statewidget_mouse_out_event);
			addEventListener(MouseEvent.MOUSE_MOVE, statewidget_mouse_move_event);
			
			tf_message = new TextField();
			tf_message.background = true;
			tf_message.backgroundColor = 0xcccccc;
			tf_message.mouseEnabled = false;
			tf_message.autoSize = TextFieldAutoSize.LEFT;
			
			tooltip_enable();
		}
		
		/**
		 * Show the tooltip if the mouse is over the state  
		 * @param e
		 * 
		 */
		private function statewidget_mouse_over_event(e:MouseEvent):void
		{
			if(prb_show_tooltip)
				addChild(tf_message);
		}
		
		/**
		 * Remove the tooltip if the mouse is out of the state 
		 * @param e
		 */
		private function statewidget_mouse_out_event(e:MouseEvent):void
		{
			if(tf_message.parent)
				removeChild(tf_message);
		}
		
		/**
		 * If the mouse is moving over the state widget,
		 * place the tooltip always above and near the mouse 
		 * @param e
		 * 
		 */
		private function statewidget_mouse_move_event(e:MouseEvent):void
		{
			tf_message.x = mouseX;
			tf_message.y = mouseY - tf_message.height;
			var globalPoint:Point = localToGlobal(new Point(tf_message.x, tf_message.y));
			if(globalPoint.y < 0)
				tf_message.y -= globalPoint.y;
			if(globalPoint.y + tf_message.height > stage.stageHeight)
				tf_message.y = stage.stageHeight - tf_message.height;
			if(globalPoint.x < 0)
				tf_message.x -= globalPoint.x;
			if(globalPoint.x + tf_message.width > stage.stageWidth)
				tf_message.x = stage.stageWidth - tf_message.width;
		}
		
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
		
		
		public function tooltip_enable():void
		{
			prb_show_tooltip = true;
		}
		
		public function tooltip_disable():void
		{
			prb_show_tooltip = false;			
		}
		
		
	}
}