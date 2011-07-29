package tests.br.poli.ecomp.geav.nhe.model.state
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
	import br.poli.ecomp.geav.nhe.model.errors.StateError;
	import br.poli.ecomp.geav.nhe.model.state.State;
	
	public class StateTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var state:State = new State();
			assertNotNull("State cannot be null", state);
			
		}
		
		[Test]
		public function shouldAddChild():void
		{
			var root:State = new State();
			var child:State = new State();
			root.addChild(child);
			assertTrue("There should have 1 child", root.prn_num_children == 1);
			assertEquals(root.prl_children[0], child);
		}
		
		[Test]
		public function shouldRemoveChild():void
		{
			var root:State = new State();
			var child:State = new State();
			root.addChild(child);
			var removed:State = root.removeChild(child);
			assertEquals("There should not have child", root.prn_num_children, 0);
			assertEquals("The removed state should be equal to the criterium state", child, removed);
			assertThrows(StateError,function():void
			{
				root.removeChild(child);
			}); 
		}
		
		
		[Test]
		public function shouldAddAction():void
		{
			var state:State = new State();
			var action:Action = new Action();
			state.pao_action = action;
			assertEquals("Should be equals", state.pao_action, action);
		}
		
		[Test]
		public function shouldClone():void
		{
			var state:State = new State();
			var cloned:State = state.clone(false);
			assertNotSame("Should not be equal",state,cloned);
			var childOriginal:State = new State();
			state.addChild(childOriginal);
			var cloned2:State = state.clone(true);
			assertNotSame("Child should not be equal", cloned2.prl_children[0], childOriginal);
		}
		
		[Test]
		public function shouldBeAncestor():void
		{
			var root:State = new State();
			var son:State = new State();
			var grandson:State = new State();
			root.addChild(son);
			son.addChild(grandson);
			assertTrue(grandson.isAncestor(root));
			assertTrue(grandson.isAncestor(son));
			assertTrue(son.isAncestor(root));
			
		}
		
		[Test]
		public function shouldBeDescendent():void
		{
			var root:State = new State();
			var son:State = new State();
			var grandson:State = new State();
			root.addChild(son);
			son.addChild(grandson);
			assertTrue(root.isDescendent(grandson));
			assertTrue(son.isDescendent(grandson));
			assertTrue(root.isDescendent(son));
		}
		
		[Test]
		public function shouldGetCorrectDepth():void
		{
			var root:State = new State();
			var son:State = new State();
			var grandson:State = new State();
			root.addChild(son);
			son.addChild(grandson);
			assertEquals(root.prn_depth, 0);
			assertEquals(son.prn_depth, 1);
			assertEquals(grandson.prn_depth, 2);
		}
		
		[Test]
		public function shouldGetRelativeDepth():void
		{
			var root:State = new State();
			var son:State = new State();
			var grandson:State = new State();
			root.addChild(son);
			son.addChild(grandson);
			assertEquals(grandson.depthFromAncestor(son), 1);
			assertEquals(son.depthFromAncestor(root), 1);
			assertEquals(grandson.depthFromAncestor(root), 2);
			assertThrows(StateError,function():void{grandson.depthFromAncestor(grandson)});
		}
		
		[Test]
		public function shouldGetRoot():void
		{
			var root:State = new State();
			var son:State = new State();
			var grandson:State = new State();
			root.addChild(son);
			son.addChild(grandson);
			assertEquals(grandson.pro_root, root);
		}
		
		[Test]
		public function shouldSearchFromAction():void
		{
			var root:State = new State();
			var child1:State = new State();
			var child2:State = new State();
			var child3:State = new State();
			var action1:Action = new Action();
			var action2:Action = new Action();
			child1.pao_action = action1;
			child3.pao_action = action2;
			root.addChild(child1);
			root.addChild(child2);
			root.addChild(child3);
			assertEquals(root.searchFromAction(action1), child1);
			assertEquals(root.searchFromAction(action2), child3);
			assertNull(root.searchFromAction(new Action()));
		}
		
		[Test]
		public function shouldGetParent():void
		{
			var root:State = new State();
			var son:State = new State();
			var grandson:State = new State();
			root.addChild(son);
			son.addChild(grandson);
			assertEquals(grandson.pro_parent, son);
			assertEquals(son.pro_parent, root);
			
			
		}
		
		[Test]
		public function shouldGetNumChildren():void
		{
			var root:State = new State();
			var child1:State = new State();
			var child2:State = new State();
			var child3:State = new State();
			root.addChild(child1);
			assertEquals(root.prn_num_children, 1);
			root.addChild(child2);
			assertEquals(root.prn_num_children, 2);
			root.addChild(child3);
			assertEquals(root.prn_num_children, 3);
		}
		public function StateTest(){}
	}
}