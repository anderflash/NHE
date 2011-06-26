package br.poli.ecomp.geav.nhe.model.db.aca;import br.poli.ecomp.geav.nhe.model.db.Table;import br.poli.ecomp.geav.nhe.model.db.cmp.IComposicao;import br.poli.ecomp.geav.nhe.model.db.ptc.IParticipacao;import br.poli.ecomp.geav.nhe.model.db.tpa.ITipoAcao;	public class Acao extends Table implements IAcao{	private int aca_identificador;	private IParticipacao ptc_identificador;	private ITipoAcao tpa_identificador;	private IAcao aca_pai;	private IComposicao cmp_identificador;	private String aca_data_atual;		public Acao()	{	}	@Override	public String get_aca_data_atual() {		return this.aca_data_atual;	}	@Override	public int get_aca_identificador() {		return this.aca_identificador;	}	@Override	public IAcao get_aca_pai() {		return this.aca_pai;	}	@Override	public IComposicao get_cmp_identificador() {		return this.cmp_identificador;	}	@Override	public IParticipacao get_ptc_identificador() {		return this.ptc_identificador;	}	@Override	public ITipoAcao get_tpa_identificador() {		return this.tpa_identificador;	}	@Override	public void set_aca_data_atual(String value) {		this.aca_data_atual = value;	}	@Override	public void set_aca_identificador(int value) {		this.aca_identificador = value;	}	@Override	public void set_aca_pai(IAcao value) {		this.aca_pai = value;	}	@Override	public void set_cmp_identificador(IComposicao value) {		this.cmp_identificador = value;	}	@Override	public void set_ptc_identificador(IParticipacao value) {		this.ptc_identificador = value;	}	@Override	public void set_tpa_identificador(ITipoAcao value) {		this.tpa_identificador = value;	}	}
