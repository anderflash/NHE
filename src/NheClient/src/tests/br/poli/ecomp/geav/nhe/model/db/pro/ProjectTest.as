package tests.br.poli.ecomp.geav.nhe.model.db.pro
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.cpl.Coupled;
	import br.poli.ecomp.geav.nhe.model.db.mdl.Model;
	import br.poli.ecomp.geav.nhe.model.db.pro.Project;
	
	public class ProjectTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var project:Project = new Project();
			assertNotNull("Project cannot be null", project);
			
		}
		[Test]
		public function shouldGetSetId():void
		{
			var project:Project = new Project();
			project.pro_identificador = 1;
			assertEquals(project.pro_identificador, 1);
		}
		[Test]
		public function shouldGetSetTitle():void
		{
			var project:Project = new Project();
			project.pro_title = "2008-05-01";
			assertEquals(project.pro_title, "2008-05-01");
		}
		[Test]
		public function shouldGetSetDescription():void
		{
			var project:Project = new Project();
			project.pro_description = "2008-05-01";
			assertEquals(project.pro_description, "2008-05-01");
		}
		[Test]
		public function shouldGetSetFinished():void
		{
			var project:Project = new Project();
			
			project.pro_finished = 1;
			assertEquals(project.pro_finished, 1);
		}
		[Test]
		public function shouldGetSetActionCurrent():void
		{
			var project:Project = new Project();
			var action:Action = new Action();
			
			project.act_identificador = action;
			assertEquals(project.act_identificador, action);
		}
		
		[Test]
		public function shouldGetSetModelPath():void
		{
			var project:Project = new Project();
			project.pro_model_path = "model_path";
			
			
			assertEquals(project.pro_model_path, "model_path");
		}
		[Test]
		public function shouldGetSetCoupled():void
		{
			var project:Project = new Project();
			var coupled:Coupled = new Coupled();
			project.cpl_identificador = coupled;
			assertEquals(project.cpl_identificador, coupled);
		}
		public function ProjectTest(){}
	}
}