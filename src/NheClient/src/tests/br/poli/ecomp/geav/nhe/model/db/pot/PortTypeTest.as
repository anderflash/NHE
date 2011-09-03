package tests.br.poli.ecomp.geav.nhe.model.db.pot
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.pot.PortType;
	
	public class PortTypeTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var portType:PortType = new PortType();
			assertNotNull("PortType cannot be null", portType);
			
		}
		[Test]
		public function shouldGetSetId():void
		{
			var portType:PortType = new PortType();
			portType.pot_identificador = 1;
			assertEquals(portType.pot_identificador, 1);
		}
		[Test]
		public function shouldGetSetDescription():void
		{
			var portType:PortType = new PortType();
			portType.pot_description = "2008-05-01";
			assertEquals(portType.pot_description, "2008-05-01");
		}
		
		
		public function PortTypeTest(){}
	}
}