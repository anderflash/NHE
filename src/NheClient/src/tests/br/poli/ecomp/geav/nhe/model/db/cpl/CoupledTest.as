package tests.br.poli.ecomp.geav.nhe.model.db.cpl
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.cpl.Coupled;
	import br.poli.ecomp.geav.nhe.model.db.mdl.Model;
	
	public class CoupledTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var coupled:Coupled = new Coupled();
			assertNotNull("Coupled cannot be null", coupled);
			
		}
		[Test]
		public function shouldGetSetId():void
		{
			var coupled:Coupled = new Coupled();
			coupled.cpl_identificador = 1;
			assertEquals(coupled.cpl_identificador, 1);
		}
		[Test]
		public function shouldGetSetDescription():void
		{
			var coupled:Coupled = new Coupled();
			coupled.cpl_description = "2008-05-01";
			assertEquals(coupled.cpl_description, "2008-05-01");
		}
		
		[Test]
		public function shouldGetSetModel():void
		{
			var coupled:Coupled = new Coupled();
			var model:Model = new Model();
			
			coupled.mdl_identificador = model;
			assertEquals(coupled.mdl_identificador, model);
		}
		
		public function CoupledTest(){}
	}
}