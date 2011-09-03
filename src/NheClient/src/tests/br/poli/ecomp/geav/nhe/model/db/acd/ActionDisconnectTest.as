package tests.br.poli.ecomp.geav.nhe.model.db.acd
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertNotSame;
	import asunit.asserts.assertNull;
	import asunit.asserts.assertThrows;
	import asunit.asserts.assertTrue;
	import asunit.framework.Async;
	
	import away3d.loaders.parsers.AC3DParser;
	
	import br.poli.ecomp.geav.nhe.model.db.acd.ActionDisconnect;
	import br.poli.ecomp.geav.nhe.model.db.aco.ActionConnect;
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.atp.ActionType;
	import br.poli.ecomp.geav.nhe.model.db.mdl.Model;
	import br.poli.ecomp.geav.nhe.model.db.por.Port;
	import br.poli.ecomp.geav.nhe.model.db.ptc.Participation;
	import br.poli.ecomp.geav.nhe.model.errors.StateError;
	import br.poli.ecomp.geav.nhe.model.state.State;
	
	public class ActionDisconnectTest
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
			var actionDisconnect:ActionDisconnect = new ActionDisconnect();
			actionDisconnect.acd_identificador = 1;
			assertEquals(actionDisconnect.acd_identificador, 1);
		}
		[Test]
		public function shouldGetSetAction():void
		{
			var actionDisconnect:ActionDisconnect = new ActionDisconnect();
			var action:Action = new Action();
			
			actionDisconnect.act_identificador = action;
			assertEquals(actionDisconnect.act_identificador, action);
		}
		[Test]
		public function shouldGetSetPortOrigin():void
		{
			var actionDisconnect:ActionDisconnect = new ActionDisconnect();
			var port:Port = new Port();
			
			actionDisconnect.por_origin = port;
			assertEquals(actionDisconnect.por_origin, port);
		}
		
		
		[Test]
		public function shouldGetSetPortDestiny():void
		{
			var actionDisconnect:ActionDisconnect = new ActionDisconnect();
			var port:Port = new Port();
			
			actionDisconnect.por_destiny = port;
			assertEquals(actionDisconnect.por_destiny, port);
		}
		
		public function ActionDisconnectTest(){}
	}
}