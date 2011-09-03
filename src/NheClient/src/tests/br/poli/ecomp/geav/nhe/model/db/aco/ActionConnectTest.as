package tests.br.poli.ecomp.geav.nhe.model.db.aco
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.aco.ActionConnect;
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.por.Port;
	
	public class ActionConnectTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var action:ActionConnect = new ActionConnect();
			assertNotNull("Action cannot be null", action);
			
		}
		[Test]
		public function shouldGetSetId():void
		{
			var actionConnect:ActionConnect = new ActionConnect();
			actionConnect.aco_identificador = 1;
			assertEquals(actionConnect.aco_identificador, 1);
		}
		[Test]
		public function shouldGetSetAction():void
		{
			var actionDisconnect:ActionConnect = new ActionConnect();
			var action:Action = new Action();
			
			actionDisconnect.act_identificador = action;
			assertEquals(actionDisconnect.act_identificador, action);
		}
		[Test]
		public function shouldGetSetPortOrigin():void
		{
			var actionDisconnect:ActionConnect = new ActionConnect();
			var port:Port = new Port();
			
			actionDisconnect.por_origin = port;
			assertEquals(actionDisconnect.por_origin, port);
		}
		
		
		[Test]
		public function shouldGetSetPortDestiny():void
		{
			var actionConnect:ActionConnect = new ActionConnect();
			var port:Port = new Port();
			
			actionConnect.por_destiny = port;
			assertEquals(actionConnect.por_destiny, port);
		}
		
		public function ActionConnectTest(){}
	}
}