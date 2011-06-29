package br.poli.ecomp.geav.nhe.model.db.usr;

import br.poli.ecomp.geav.nhe.model.db.Table;

public class User extends Table implements IUser
{
	
	private int _usr_identificador;
	private String _usr_nome;
	private String _usr_login;
	private String _usr_senha;
	private String _usr_email;
	
	public User() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String get_usr_email() {
		return this._usr_email;
	}

	@Override
	public int get_usr_identificador() {
		return this._usr_identificador;

	}

	@Override
	public String get_usr_login() {
		return this._usr_login;
	}

	@Override
	public String get_usr_nome() {
		return this._usr_nome;
	}

	@Override
	public String get_usr_senha() {
		return this._usr_senha;
	}

	@Override
	public void set_usr_email(String value) {
		this._usr_email = value;

	}

	@Override
	public void set_usr_identificador(int value) {
		this._usr_identificador = value;

	}

	@Override
	public void set_usr_login(String value) {
		this._usr_login = value;

	}

	@Override
	public void set_usr_nome(String value) {
		this._usr_nome = value;

	}

	@Override
	public void set_usr_senha(String value) {
		this._usr_senha = value;

	}

	@Override
	public int get_identificador() {
		// TODO Auto-generated method stub
		return 0;
	}
}
