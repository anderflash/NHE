package br.poli.ecomp.geav.nhe.model.connection;

public class DBConnectionInfo
{
	public static String HOST = "localhost";
	public static String USER = "nhe";
	public static String PASSWORD = "nhe";
	public static String DB_NAME = "nhe";
	
	private String host;
	private String user;
	private String password;
	private String db_name;
	
	public DBConnectionInfo()
	{
		host = HOST;
		user = USER;
		password = PASSWORD;
		db_name = DB_NAME;
	}
	
	public DBConnectionInfo(String host, String user, String password, String db_name)
	{
		this.host = host;
		this.user = user;
		this.password = password;
		this.db_name = db_name;
	}
	
	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDb_name() {
		return db_name;
	}

	public void setDb_name(String dbName) {
		db_name = dbName;
	}
}
