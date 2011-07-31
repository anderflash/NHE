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
			
			options = new Vector.<ModelView>();
			options.push(new GeneratorView());
			options.push(new ProcessorView());
			options.push(new ConsumerView());
			options.push(new RouterView());
			options.push(new EraserView());
			options.push(new ConnectView());
			
			menuLeft = new MenuView(options.slice(0,3));
			menuRight = new MenuView(options.slice(3,6));
			addChild(menuLeft);
			addChild(menuRight);
			menuLeft.x = -250;
			menuRight.x = 250;
			menuLeft.arrangeOptions();
			menuRight.arrangeOptions();
		}
		
		private function addModule():void
		{
			
		}
		
		private function removeModule():void
		{
			
		}
		
		public function set lights(value:Array):void
		{
			menuLeft.lights = value;
			menuRight.lights = value;
		}
	}
}