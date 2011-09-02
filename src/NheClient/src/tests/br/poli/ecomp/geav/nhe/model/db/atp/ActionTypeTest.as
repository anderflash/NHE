package tests.br.poli.ecomp.geav.nhe.model.db.atp
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.atp.ActionType;
	
	public class ActionTypeTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var actionType:ActionType = new ActionType();
			assertNotNull("ActionType cannot be null", actionType);
		}
		
		[Test]
		public function shouldGetSetId():void
		{
			var actionType:ActionType = new ActionType();
			actionType.atp_identificador = 1;
			assertEquals(actionType.atp_identificador, 1);
		}
		
		[Test]
		public function shouldGetSetDescription():void
		{
			var actionType:ActionType = new ActionType();
			actionType.atp_name = "Remoção";
			assertEquals(actionType.atp_name, "Remoção");
		}
		
		
		public function ActionTypeTest(){}
	}
}