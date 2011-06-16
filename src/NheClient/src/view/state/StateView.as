package view.state
{
	import controller.state.StateController;
	
	import flash.display.Sprite;
	
	import model.state.State;
	
	import view.util.ITooltipavel;
	
	public class StateView extends Sprite implements ITooltipavel;
	{
		private var sprite:IStateWidget;
		private var controller:StateController;
		
		private var _pas_state_text:String;
		private var _pas_tooltip_text:String;
		
		public function StateWidget()
		{
			super();
		}
		
		public function draw():void
		{
			sprite
		}
		
		
		/**
		 *  
		 * 
		 */
		public function enable():void
		{
			
		}
		
		/**
		 *  
		 * 
		 */		
		public function disable():void
		{
			
		}
		
		/**
		 *  
		 * 
		 */		
		public function select():void
		{
			
		}
		
		public function get pas_state_text():String
		{
			return this._pas_state_text;
		}
		
		public function set pas_state_text(value:String):void
		{
			this._pas_state_text = value;
		}
		
		public function get pas_tooltip_text():String
		{
			return this._pas_tooltip_text;
		}
		
		public function set pas_tooltip_text(value:String):void
		{
			this._pas_tooltip_text = value;
		}
		
		
		public function tooltip_enable():void
		{
			
		}
		
		public function tooltip_disable():void
		{
			
		}
		
		public function tooltip_get():Sprite
		{
			
		}
		
	}
}