package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.ObjectContainer3D;
	import away3d.primitives.Cone;
	
	public class MenuView extends ObjectContainer3D
	{
		private var options:Vector.<ModelView>;
		
		public function MenuView(options:Vector.<ModelView>)
		{
			trace(options);
			this.options = options;
			super();
		}
		
		public function arrangeOptions():void
		{
			trace(options.length);
			for(var i:uint = 0; i < options.length; i++)
			{
				trace("adicionado");
				addChild(options[i]);
				options[i].x = 0;
				options[i].z = 100 * i;
			}
		}
		public function set lights(value:Array):void
		{
			for each(var model:ModelView in options)
			{
				model.lights = value;
			}
		}
		
	}
}