package tests.br.poli.ecomp.geav.nhe.model.db
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.framework.Async;
	
	import br.poli.ecomp.geav.nhe.model.db.pfl.Profile;
	import br.poli.ecomp.geav.nhe.model.db.usr.User;
	
	public class DatabaseTest
	{
		[Inject]
		public var async:Async;
		
		[Test]
		public function shouldInstantiate():void
		{
			var user:User = new User();
			assertNotNull("User cannot be null", user);
			
		}
		[Test]
		public function shouldGetSetId():void
		{
			var user:User = new User();
			user.usr_identificador = 1;
			assertEquals(user.usr_identificador, 1);
		}
		[Test]
		public function shouldGetSetName():void
		{
			var user:User = new User();
			user.usr_name = "anderson";
			assertEquals(user.usr_name, "anderson");
		}
		[Test]
		public function shouldGetSetLogin():void
		{
			var user:User = new User();
			
			user.usr_login = "anderson";
			assertEquals(user.usr_login, "anderson");
		}
		[Test]
		public function shouldGetSetPassword():void
		{
			var user:User = new User();
			user.usr_password = "password";
			
			assertEquals(user.usr_password, "password");
		}

		[Test]
		public function shouldGetSetEmail():void
		{
			var user:User = new User();
			user.usr_email = "email@email";
			assertEquals(user.usr_email, "email@email");
		}

		
		public function DatabaseTest(){}
	}
}