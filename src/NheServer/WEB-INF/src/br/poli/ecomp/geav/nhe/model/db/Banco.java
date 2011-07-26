package br.poli.ecomp.geav.nhe.model.db;

import br.poli.ecomp.geav.nhe.model.db.act.Action;
import br.poli.ecomp.geav.nhe.model.db.atp.ActionType;
import br.poli.ecomp.geav.nhe.model.db.cmp.Composition;
import br.poli.ecomp.geav.nhe.model.db.pfl.Profile;
import br.poli.ecomp.geav.nhe.model.db.pro.Project;
import br.poli.ecomp.geav.nhe.model.db.ptc.Participation;
import br.poli.ecomp.geav.nhe.model.db.usr.User;

public class Banco extends Database
{
	private static Banco banco;
	public static final String ACA = "aca";
	public static final String CMP = "cmp";
	public static final String PER = "per";
	public static final String PRO = "pro";
	public static final String PTC = "ptc";
	public static final String TPA = "tpa";
	public static final String USU = "usu";
	public static final String ACAO_STR = "Acao";
	public static final String COMPOSICAO_STR = "Composicao";
	public static final String PERFIL_STR = "Perfil";
	public static final String PROJETO_STR = "Projeto";
	public static final String PARTICIPACAO_STR = "Participacao";
	public static final String TIPOACAO_STR = "TipoAcao";
	public static final String USUARIO_STR = "Usuario";
	public static final Class<? extends Table> ACAO = Action.class;
	public static final Class<? extends Table> COMPOSITION = Composition.class;
	public static final Class<? extends Table> PROFILE = Profile.class;
	public static final Class<? extends Table> PROJECT = Project.class;
	public static final Class<? extends Table> PARTICIPACAO = Participation.class;
	public static final Class<? extends Table> TIPOACAO = ActionType.class;
	public static final Class<? extends Table> USUARIO = User.class;
	private Banco()
	{
		criarRepositorio(ACA,ACAO_STR,ACAO);
		criarRepositorio(CMP,COMPOSICAO_STR,COMPOSITION);
		criarRepositorio(PER,PERFIL_STR,PROFILE);
		criarRepositorio(PRO,PROJETO_STR,PROJECT);
		criarRepositorio(PTC,PARTICIPACAO_STR,PARTICIPACAO);
		criarRepositorio(TPA,TIPOACAO_STR,TIPOACAO);
		criarRepositorio(USU,USUARIO_STR,USUARIO);
	}
	public Banco getInstance()
	{
		if(banco == null)
			banco = new Banco();
		return banco;
	}
}
