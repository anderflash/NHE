package tests.br.poli.ecomp.geav.nhe.model.db.pfl
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.pfl.Profile;
	
	public class ProfileTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var profile:Profile = new Profile();
			assertNotNull("Profile cannot be null", profile);
			
		}
		[Test]
		public function shouldGetSetId():void
		{
			var profile:Profile = new Profile();
			profile.pfl_identificador = 1;
			assertEquals(profile.pfl_identificador, 1);
		}
		[Test]
		public function shouldGetSetDescription():void
		{
			var profile:Profile = new Profile();
			profile.pfl_description = "2008-05-01";
			assertEquals(profile.pfl_description, "2008-05-01");
		}
		
		
		public function ProfileTest(){}
	}
}