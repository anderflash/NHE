package br.poli.ecomp.geav.nhe.model.db.atp;

import br.poli.ecomp.geav.nhe.model.db.Table;

public class ActionType extends Table implements IActionType
{
	private int _atp_identificador;
	private String _atp_nome;
	
	public ActionType()
	{
		
	}
	
	@Override
	public int get_atp_identificador() {
		return this._atp_identificador;
	}

	@Override
	public String get_atp_nome() {
		return this._atp_nome;
	}

	@Override
	public void set_atp_identificador(int value) {
		this._atp_identificador = value;
	}

	@Override
	public void set_atp_nome(String value) {
		this._atp_nome = value;
	}

}
