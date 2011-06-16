package view.util
{
	import flash.display.Sprite;

	public interface ITooltipavel
	{
		/**
		 * Enable the tooltip 
		 * 
		 */
		function tooltip_enable():void;
		
		/**
		 * Disable the tooltip 
		 * 
		 */
		function tooltip_disable():void;
		
		/**
		 * Get the tooltip 
		 * @return 
		 * 
		 */
		function tooltip_get():Sprite;
	}
}