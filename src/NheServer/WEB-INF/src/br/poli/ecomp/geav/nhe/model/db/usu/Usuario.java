package br.poli.ecomp.geav.nhe.model.db.usu;

import br.poli.ecomp.geav.nhe.model.db.Table;

public class Usuario extends Table implements IUsuario
{
	
	private int _usu_identificador;
	private String _usu_nome;
	private String _usu_login;
	private String _usu_senha;
	private String _usu_email;
	
	public Usuario() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String get_usu_email() {
		return this._usu_email;
	}

	@Override
	public int get_usu_identificador() {
		return this._usu_identificador;

	}

	@Override
	public String get_usu_login() {
		return this._usu_login;
	}

	@Override
	public String get_usu_nome() {
		return this._usu_nome;
	}

	@Override
	public String get_usu_senha() {
		return this._usu_senha;
	}

	@Override
	public void set_usu_email(String value) {
		this._usu_email = value;

	}

	@Override
	public void set_usu_identificador(int value) {
		this._usu_identificador = value;

	}

	@Override
	public void set_usu_login(String value) {
		this._usu_login = value;

	}

	@Override
	public void set_usu_nome(String value) {
		this._usu_nome = value;

	}

	@Override
	public void set_usu_senha(String value) {
		this._usu_senha = value;

	}

	@Override
	public int get_identificador() {
		// TODO Auto-generated method stub
		return 0;
	}
}
