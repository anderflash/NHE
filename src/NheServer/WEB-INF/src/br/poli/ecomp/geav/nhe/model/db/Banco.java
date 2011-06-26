package br.poli.ecomp.geav.nhe.model.db;

import br.poli.ecomp.geav.nhe.model.db.aca.Acao;
import br.poli.ecomp.geav.nhe.model.db.cmp.Composicao;
import br.poli.ecomp.geav.nhe.model.db.per.Perfil;
import br.poli.ecomp.geav.nhe.model.db.pro.Projeto;
import br.poli.ecomp.geav.nhe.model.db.ptc.Participacao;
import br.poli.ecomp.geav.nhe.model.db.tpa.TipoAcao;
import br.poli.ecomp.geav.nhe.model.db.usu.Usuario;

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
	public static final Class<? extends Table> ACAO = Acao.class;
	public static final Class<? extends Table> COMPOSICAO = Composicao.class;
	public static final Class<? extends Table> PERFIL = Perfil.class;
	public static final Class<? extends Table> PROJETO = Projeto.class;
	public static final Class<? extends Table> PARTICIPACAO = Participacao.class;
	public static final Class<? extends Table> TIPOACAO = TipoAcao.class;
	public static final Class<? extends Table> USUARIO = Usuario.class;
	private Banco()
	{
		criarRepositorio(ACA,ACAO_STR,ACAO);
		criarRepositorio(CMP,COMPOSICAO_STR,COMPOSICAO);
		criarRepositorio(PER,PERFIL_STR,PERFIL);
		criarRepositorio(PRO,PROJETO_STR,PROJETO);
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
