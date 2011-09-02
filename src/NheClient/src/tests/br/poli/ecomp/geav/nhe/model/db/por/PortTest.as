package tests.br.poli.ecomp.geav.nhe.model.db.por
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.atp.ActionType;
	import br.poli.ecomp.geav.nhe.model.db.mdl.Model;
	import br.poli.ecomp.geav.nhe.model.db.por.Port;
	import br.poli.ecomp.geav.nhe.view.gui.AboutView;
	
	public class PortTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var port:Port = new Port();
			assertNotNull("Port cannot be null", port);
		}
		
		[Test]
		public function shouldGetSetId():void
		{
			var port:Port = new Port();
			port.por_identificador = 1;
			assertEquals(port.por_identificador, 1);
		}
		
		[Test]
		public function shouldGetSetDescription():void
		{
			var port:Port = new Port();
			port.por_description = "port";
			assertEquals(port.por_description, "port");
		}

		[Test]
		public function shouldGetSetIn():void
		{
			var port:Port = new Port();
			port.por_in = 1;
			assertEquals(port.por_in, 1);
		}
		
		[Test]
		public function shouldGetSetInfluencee():void
		{
			var port:Port = new Port();
			var portInfluencee:Port = new Port();
			port.por_influencee = portInfluencee;
			assertEquals(port.por_influencee, portInfluencee);
		}
		
		[Test]
		public function shouldGetSetModel():void
		{
			var port:Port = new Port();
			var model:Model = new Model();
			port.mdl_identificador = model;
			assertEquals(port.mdl_identificador, model);
		}
		
		
		public function PortTest(){}
	}
}