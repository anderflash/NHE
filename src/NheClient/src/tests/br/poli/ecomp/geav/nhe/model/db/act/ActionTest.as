package tests.br.poli.ecomp.geav.nhe.model.db.act
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
	
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.atp.ActionType;
	import br.poli.ecomp.geav.nhe.model.db.mdl.Model;
	import br.poli.ecomp.geav.nhe.model.db.ptc.Participation;
	import br.poli.ecomp.geav.nhe.model.errors.StateError;
	import br.poli.ecomp.geav.nhe.model.state.State;
	
	public class ActionTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var action:Action = new Action();
			assertNotNull("Action cannot be null", action);
			
		}
		[Test]
		public function shouldGetSetId():void
		{
			var action:Action = new Action();
			action.act_identificador = 1;
			assertEquals(action.act_identificador, 1);
		}
		[Test]
		public function shouldGetSetDateCurrent():void
		{
			var action:Action = new Action();
			action.act_date_current = "2008-05-01";
			assertEquals(action.act_date_current, "2008-05-01");
		}
		[Test]
		public function shouldGetSetParent():void
		{
			var action:Action = new Action();
			var parent:Action = new Action();
			
			action.act_parent = parent;
			assertEquals(action.act_parent, parent);
		}
		[Test]
		public function shouldGetSetType():void
		{
			var action:Action = new Action();
			var type:ActionType = new ActionType();
			
			action.atp_identificador = type;
			assertEquals(action.atp_identificador, type);
		}
		
		[Test]
		public function shouldGetSetModel():void
		{
			var action:Action = new Action();
			var model:Model = new Model();
			
			action.mdl_identificador = model;
			assertEquals(action.mdl_identificador, model);
		}
		
		[Test]
		public function shouldGetSetParticipation():void
		{
			var action:Action = new Action();
			var participation:Participation = new Participation();
			
			action.ptc_identificador = participation;
			assertEquals(action.ptc_identificador, participation);
		}
		
		
		public function ActionTest(){}
	}
}