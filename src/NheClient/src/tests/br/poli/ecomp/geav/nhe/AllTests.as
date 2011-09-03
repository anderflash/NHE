
package tests.br.poli.ecomp.geav.nhe
{
	import tests.br.poli.ecomp.geav.nhe.model.db.acd.ActionDisconnectTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.aco.ActionConnectTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.act.ActionTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.atm.AtomicTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.atp.ActionTypeTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.att.AtomicTypeTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.cpl.CoupledTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.mdl.ModelTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.pfl.ProfileTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.por.PortTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.pot.PortTypeTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.pro.ProjectTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.ptc.ParticipationTest;
	import tests.br.poli.ecomp.geav.nhe.model.db.usr.UserTest;

	[Suite]
	public class AllTests
	{
		//MODEL
		////State
		//public var stateTest:StateTest;
		////db
		//////acd
		public var actionDisconnectTest:ActionDisconnectTest;
		//////aco
		public var actionConnectTest:ActionConnectTest;
		//////act
		public var actionTest:ActionTest;
		//////atm
		public var atomicTest:AtomicTest;
		//////atp
		public var actionTypeTest:ActionTypeTest;
		//////att
		public var atomicTypeTest:AtomicTypeTest;
		//////cpl
		public var coupledTest:CoupledTest;
		//////mdl
		public var modelTest:ModelTest;
		//////pfl
		public var profileTest:ProfileTest;
		//////por
		public var portTest:PortTest;
		//////pot
		public var portTypeTest:PortTypeTest;
		//////pro
		public var projectTest:ProjectTest;
		//////ptc
		public var participationTest:ParticipationTest;
		//////usr
		public var userTest:UserTest;
		
		
		//VIEW
		////State
		
		//CONTROLLER
		////State
		
		public function AllTests(){}
	}


}