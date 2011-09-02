package br.poli.ecomp.geav.nhe.model.db
{
	import br.poli.ecomp.geav.nhe.model.db.acd.ActionDisconnect;
	import br.poli.ecomp.geav.nhe.model.db.aco.ActionConnect;
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.atm.Atomic;
	import br.poli.ecomp.geav.nhe.model.db.atp.ActionType;
	import br.poli.ecomp.geav.nhe.model.db.att.AtomicType;
	import br.poli.ecomp.geav.nhe.model.db.cpl.Coupled;
	import br.poli.ecomp.geav.nhe.model.db.mdl.Model;
	import br.poli.ecomp.geav.nhe.model.db.pfl.Profile;
	import br.poli.ecomp.geav.nhe.model.db.por.Port;
	import br.poli.ecomp.geav.nhe.model.db.pot.PortType;
	import br.poli.ecomp.geav.nhe.model.db.pro.Project;
	import br.poli.ecomp.geav.nhe.model.db.ptc.Participation;
	import br.poli.ecomp.geav.nhe.model.db.usr.User;
	
	import marcozero.marzsdk.net.db.MZDatabase;
	
	public class Database extends MZDatabase
	{
		public static const ACT:String = "act";
		public static const ACO:String = "aco";
		public static const ACD:String = "acd";
		public static const ATP:String = "atp";
		public static const PFL:String = "pfl";
		public static const PRO:String = "pro";
		public static const PTC:String = "ptc";
		public static const MDL:String = "mdl";
		public static const POR:String = "por";
		public static const CPL:String = "cpl";
		public static const ATM:String = "atm";
		public static const ATT:String = "att";
		public static const POT:String = "pot";
		public static const USR:String = "usr";

		public static const ACTION_STR:String = "Action";
		public static const ACTIONCONNECT_STR:String = "ActionConnect";
		public static const ACTIONDISCONNECT_STR:String = "ActionDisconnect";
		public static const ACTIONTYPE_STR:String = "ActionType";
		public static const PROFILE_STR:String = "Profile";
		public static const PROJECT_STR:String = "Project";
		public static const PARTICIPATION_STR:String = "Participation";
		public static const MODEL_STR:String = "Model";
		public static const PORT_STR:String = "Port";
		public static const COUPLED_STR:String = "Coupled";
		public static const ATOMIC_STR:String = "Atomic";
		public static const ATOMICTYPE_STR:String = "AtomicType";
		public static const PORTTYPE_STR:String = "PortType";
		public static const USER_STR:String = "User";

		public static const ACTION:Class = Action;
		public static const ACTIONCONNECT:Class = ActionConnect;
		public static const ACTIONDISCONNECT:Class = ActionDisconnect;
		public static const ACTIONTYPE:Class = ActionType;
		public static const PROFILE:Class = Profile;
		public static const PROJECT:Class = Project;
		public static const PARTICIPATION:Class = Participation;
		public static const MODEL:Class = Model;
		public static const PORT:Class = Port;
		public static const COUPLED:Class = Coupled;
		public static const ATOMIC:Class = Atomic;
		public static const ATOMICTYPE:Class = AtomicType;
		public static const PORTTYPE:Class = PortType;
		public static const USER:Class = User;

		
		private static var _instance:Database = new Database();
		
		public function Database()
		{
			super();
			if(_instance) throw new Error();
			
			criarRepositorio(ACT,ACTION_STR,ACTION);
			criarRepositorio(ACO,ACTIONCONNECT_STR,ACTIONCONNECT);
			criarRepositorio(ACD,ACTIONDISCONNECT_STR,ACTIONDISCONNECT);
			criarRepositorio(ATP,ACTIONTYPE_STR,ACTIONTYPE);
			criarRepositorio(PFL,PROFILE_STR,PROFILE);
			criarRepositorio(PRO,PROJECT_STR,PROJECT);
			criarRepositorio(PTC,PARTICIPATION_STR,PARTICIPATION);
			criarRepositorio(MDL,MODEL_STR,MODEL);
			criarRepositorio(POR,PORT_STR,PORT);
			criarRepositorio(CPL,COUPLED_STR,COUPLED);
			criarRepositorio(ATM,ATOMIC_STR,ATOMIC);
			criarRepositorio(ATT,ATOMICTYPE_STR,ATOMICTYPE);
			criarRepositorio(POT,PORTTYPE_STR,PORTTYPE);
			criarRepositorio(USR,USER_STR,USER);

		}
		
		public static function get instance():Database
		{
			return _instance;
		}
	}
}
