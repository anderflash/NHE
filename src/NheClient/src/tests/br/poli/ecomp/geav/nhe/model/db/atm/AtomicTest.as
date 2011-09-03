package tests.br.poli.ecomp.geav.nhe.model.db.atm
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.atm.Atomic;
	import br.poli.ecomp.geav.nhe.model.db.atp.ActionType;
	import br.poli.ecomp.geav.nhe.model.db.att.AtomicType;
	import br.poli.ecomp.geav.nhe.model.db.cpl.Coupled;
	import br.poli.ecomp.geav.nhe.model.db.mdl.Model;
	import br.poli.ecomp.geav.nhe.model.db.ptc.Participation;
	
	public class AtomicTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var atomic:Atomic = new Atomic();
			assertNotNull("Atomic cannot be null", atomic);
			
		}
		[Test]
		public function shouldGetSetId():void
		{
			var atomic:Atomic = new Atomic();
			atomic.atm_identificador = 1;
			assertEquals(atomic.atm_identificador, 1);
		}
		[Test]
		public function shouldGetSetDescription():void
		{
			var atomic:Atomic = new Atomic();
			atomic.atm_description = "2008-05-01";
			assertEquals(atomic.atm_description, "2008-05-01");
		}
		[Test]
		public function shouldGetSetType():void
		{
			var atomic:Atomic = new Atomic();
			var type:AtomicType = new AtomicType();
			
			atomic.att_identificador = type;
			assertEquals(atomic.att_identificador, type);
		}
		[Test]
		public function shouldGetSetModel():void
		{
			var atomic:Atomic = new Atomic();
			var model:Model = new Model();
			
			atomic.mdl_identificador = model;
			assertEquals(atomic.mdl_identificador, model);
		}
		
		[Test]
		public function shouldGetSetCoupled():void
		{
			var atomic:Atomic = new Atomic();
			var coupled:Coupled = new Coupled();
			
			atomic.cpl_identificador = coupled;
			assertEquals(atomic.cpl_identificador, coupled);
		}
		
		public function AtomicTest(){}
	}
}