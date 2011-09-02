package tests.br.poli.ecomp.geav.nhe.model.db.mdl
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.atp.ActionType;
	import br.poli.ecomp.geav.nhe.model.db.mdl.Model;
	
	public class ModelTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var model:Model = new Model();
			assertNotNull("Model cannot be null", model);
		}
		
		[Test]
		public function shouldGetSetId():void
		{
			var model:Model = new Model();
			model.mdl_identificador = 1;
			assertEquals(model.mdl_identificador, 1);
		}
		
		public function ModelTest(){}
	}
}