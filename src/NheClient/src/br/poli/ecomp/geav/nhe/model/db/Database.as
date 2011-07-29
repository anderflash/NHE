package br.poli.ecomp.geav.nhe.model.db
{
	import br.poli.ecomp.geav.nhe.model.db.act.Action;
	import br.poli.ecomp.geav.nhe.model.db.atp.ActionType;
	import br.poli.ecomp.geav.nhe.model.db.cmp.Composition;
	import br.poli.ecomp.geav.nhe.model.db.pfl.Profile;
	import br.poli.ecomp.geav.nhe.model.db.pro.Project;
	import br.poli.ecomp.geav.nhe.model.db.ptc.Participation;
	import br.poli.ecomp.geav.nhe.model.db.usr.User;
	
	import marcozero.marzsdk.net.db.MZDatabase;
	
	public class Database extends MZDatabase
	{
		public static const ACT:String = "acr";
		public static const CMP:String = "cmp";
		public static const PFL:String = "pfl";
		public static const PRO:String = "pro";
		public static const PTC:String = "ptc";
		public static const ATP:String = "atp";
		public static const USR:String = "usr";
		public static const ACTION_STR:String = "Action";
		public static const COMPOSITION_STR:String = "Composition";
		public static const PROFILE_STR:String = "Profile";
		public static const PROJECT_STR:String = "Project";
		public static const PARTICIPATION_STR:String = "Participation";
		public static const ACTIONTYPE_STR:String = "ActionType";
		public static const USER_STR:String = "User";
		public static const ACTION:Class = Action;
		public static const COMPOSITION:Class = Composition;
		public static const PROFILE:Class = Profile;
		public static const PROJECT:Class = Project;
		public static const PARTICIPATION:Class = Participation;
		public static const ACTIONTYPE:Class = ActionType;
		public static const USER:Class = User;
		
		public function Database()
		{
			super();
			if(_instance) throw new Error();
			
			criarRepositorio(ACT,ACTION_STR,ACTION);
			criarRepositorio(CMP,COMPOSITION_STR,COMPOSITION);
			criarRepositorio(PFL,PROFILE_STR,PROFILE);
			criarRepositorio(PRO,PROJECT_STR,PROJECT);
			criarRepositorio(PTC,PARTICIPATION_STR,PARTICIPATION);
			criarRepositorio(ATP,ACTIONTYPE_STR,ACTIONTYPE);
			criarRepositorio(USR,USER_STR,USER);
		}
		
		public static function get instance():Database
		{
			return MZDatabase._instance as Database;
		}
	}
}
