package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.ObjectContainer3D;
	
	public class MenuView extends ObjectContainer3D
	{
		private var options:Vector.<ModelView>;
		
		public function MenuView(options:Vector.<ModelView>)
		{
			this.options = options;
			super();
		}
		
		public function arrangeOptions():void
		{
			for(var i:uint = 0; i < options.length; i++)
			{
				addChild(options[i]);
				options[i].x = 0;
				options[i].z = 50 * i;
			}
		}
	}
}