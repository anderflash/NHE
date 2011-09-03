package tests.br.poli.ecomp.geav.nhe.model.db.att
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.att.AtomicType;
	
	public class AtomicTypeTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var atomicType:AtomicType = new AtomicType();
			assertNotNull("AtomicType cannot be null", atomicType);
			
		}
		[Test]
		public function shouldGetSetId():void
		{
			var atomicType:AtomicType = new AtomicType();
			atomicType.att_identificador = 1;
			assertEquals(atomicType.att_identificador, 1);
		}
		[Test]
		public function shouldGetSetDescription():void
		{
			var atomicType:AtomicType = new AtomicType();
			atomicType.att_description = "2008-05-01";
			assertEquals(atomicType.att_description, "2008-05-01");
		}
		
		
		public function AtomicTypeTest(){}
	}
}