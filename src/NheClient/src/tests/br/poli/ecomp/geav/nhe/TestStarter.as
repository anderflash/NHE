package tests.br.poli.ecomp.geav.nhe
{
	import asunit.core.TextCore;
	
	import flash.display.Sprite;
	
	public class TestStarter extends Sprite
	{
		private var core:TextCore;
		
		public function TestStarter()
		{
			super();
			core = new TextCore();
			core.start(AllTests, null, this);
		}
	}
}