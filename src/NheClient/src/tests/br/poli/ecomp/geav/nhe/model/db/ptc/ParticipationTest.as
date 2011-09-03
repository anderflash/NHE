package tests.br.poli.ecomp.geav.nhe.model.db.ptc
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.cpl.Coupled;
	import br.poli.ecomp.geav.nhe.model.db.pfl.Profile;
	import br.poli.ecomp.geav.nhe.model.db.pro.Project;
	import br.poli.ecomp.geav.nhe.model.db.ptc.Participation;
	import br.poli.ecomp.geav.nhe.model.db.usr.User;
	import br.poli.ecomp.geav.nhe.view.gui.AboutView;
	
	public class ParticipationTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var participation:Participation = new Participation();
			assertNotNull("Participation cannot be null", participation);
			
		}
		[Test]
		public function shouldGetSetId():void
		{
			var participation:Participation = new Participation();
			participation.ptc_identificador = 1;
			assertEquals(participation.ptc_identificador, 1);
		}
		[Test]
		public function shouldGetSetProject():void
		{
			var participation:Participation = new Participation();
			var project:Project = new Project();
			participation.pro_identificador = project;
			
			assertEquals(participation.pro_identificador, project);
		}
		[Test]
		public function shouldGetSetUser():void
		{
			var participation:Participation = new Participation();
			var user:User = new User();
			
			participation.usr_identificador = user;
			assertEquals(participation.usr_identificador, user);
		}
		[Test]
		public function shouldGetSetProfile():void
		{
			var participation:Participation = new Participation();
			var profile:Profile = new Profile();
			assertNull(participation.pfl_identificador);
			participation.pfl_identificador = profile;
			assertEquals(participation.pfl_identificador, profile);
		}
		
		public function ParticipationTest(){}
	}
}