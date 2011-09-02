
package tests.br.poli.ecomp.geav.nhe
{
	import tests.br.poli.ecomp.geav.nhe.model.db.act.ActionTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.atp.ActionTypeTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.mdl.ModelTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.por.PortTest;
	import tests.br.poli.ecomp.geav.nhe.model.state.StateTest;

	[Suite]
	public class AllTests
	{
		//MODEL
		////State
		//public var stateTest:StateTest;
		////db
		//////atp
		public var actionTypeTest:ActionTypeTest;
		//////act
		public var actionTest:ActionTest;
		//////mdl
		public var modelTest:ModelTest;
		//////por
		public var portTest:PortTest;
		
		//VIEW
		////State
		
		//CONTROLLER
		////State
		
		public function AllTests(){}
	}


}