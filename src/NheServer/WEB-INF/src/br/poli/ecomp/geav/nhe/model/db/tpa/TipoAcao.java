package br.poli.ecomp.geav.nhe.model.db.tpa;

import br.poli.ecomp.geav.nhe.model.db.Table;

public class TipoAcao extends Table implements ITipoAcao
{
	private int _tpa_identificador;
	private String _tpa_nome;
	
	public TipoAcao()
	{
		
	}
	
	@Override
	public int get_tpa_identificador() {
		return this._tpa_identificador;
	}

	@Override
	public String get_tpa_nome() {
		return this._tpa_nome;
	}

	@Override
	public void set_tpa_identificador(int value) {
		this._tpa_identificador = value;
	}

	@Override
	public void set_tpa_nome(String value) {
		this._tpa_nome = value;
	}

}
