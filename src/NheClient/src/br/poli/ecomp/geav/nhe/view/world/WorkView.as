package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.ObjectContainer3D;
	
	public class WorkView extends ObjectContainer3D
	{
		private var menuLeft:MenuView;
		private var menuRight:MenuView;
		
		private var options:Vector.<ModelView>; 
		
		private var modelList:Vector.<ModelView>;
		
		public function WorkView()
		{
			super();
			modelList = new Vector.<ModelView>();
			createMenus();
			
		}
		
		private function createMenus():void
		{
			options = new Vector.<ModelView>([new GeneratorView(),
				new ProcessorView(),
				new ConsumerView(),
				new RouterView(),
				new EraserView(),
				new ConnectView()
			]);
			menuLeft = new MenuView(options.slice(0,3));
			menuRight = new MenuView(options.slice(3,6));
			addChild(menuLeft);
			addChild(menuRight);
			menuLeft.x = 0;
			menuRight.x = 500;
		}
		
		private function addModule():void
		{
			
		}
		
		private function removeModule():void
		{
			
		}
	}
}