package br.poli.ecomp.geav.nhe.model.db;

public class RepositoryException extends Exception
{
	public static final int ELEMENTO_CLASSE_ERRADA = 1;
	public static final int ELEMENTO_NAO_CADASTRADO = 2;
	public static final int ELEMENTO_JA_CADASTRADO = 3;
	
	public int type;
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public RepositoryException(int type)
	{
		super();
		this.type = type;
	}

}
