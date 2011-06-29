/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.poli.ecomp.geav.nhe.controller.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import br.poli.ecomp.geav.nhe.model.connection.DBConnectionInfo;
import br.poli.ecomp.geav.nhe.model.db.Procedures;
import br.poli.ecomp.geav.nhe.model.server.ProcedureResponse;
import br.poli.ecomp.geav.nhe.model.util.StringUtil;

/**
 * Connection class for the server
 * @author Anderson Tavares
 */
public class DBConnection {
    Connection connection;
    Statement instruction;
    ResultSet result, chaves;
    DBConnectionInfo info;
    
    private static DBConnection conexaoBD;
    

    /**
     * Database Connection class to 
     * @param info
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    private DBConnection(DBConnectionInfo info) throws ClassNotFoundException, SQLException
    {
    	Class.forName("com.mysql.jdbc.Driver");
        this.info = info;
        connection_create();
    }
    
    private DBConnection() throws ClassNotFoundException, SQLException
    {
    	Class.forName("com.mysql.jdbc.Driver");
        this.info = new DBConnectionInfo();
        connection_create();
    }
    		
    private void connection_create() throws SQLException
    {
        String connectionUrl = "jdbc:mysql://"+info.getHost()+"/"+info.getDb_name();
        connection = (Connection) DriverManager.getConnection(connectionUrl,info.getUser(),info.getPassword());
        instruction = connection.createStatement();
    }
    
    public static DBConnection get_connection() throws ClassNotFoundException, SQLException
    {
        if (conexaoBD == null)
            conexaoBD = new DBConnection();
        return conexaoBD;
    }

    public ResultSet run_query(String sql,boolean update) throws SQLException
    {
    	
        try
        {
            if(connection != null)
            {
                if(update)
                {
                    instruction.executeUpdate(sql);

                    return null;
                }
                else
                    return instruction.executeQuery(sql);
            }
            return null;
        }
        catch(SQLException e)
        {
            if(e.getMessage().contains("last packet"))
            {
                connection_create();
                return run_query(sql, update);
            }
            else
            {
                throw e;
            }
        }
    }
    
	public ProcedureResponse run_procedure(Integer procedure, Vector<String> parameters) throws SQLException
	{
		CallableStatement callable_statement;
		String sql;
		if(procedure != 0)
	    	sql = procedure_to_sql(procedure, parameters);
		else
			sql = "{call procurar_stp()}";
		
		callable_statement = connection.prepareCall(sql);
		
		Boolean has_result = callable_statement.execute();
		if(has_result)
			return resultsetToList(callable_statement.getResultSet());
		else
			return null;
	}
    
    private String procedure_to_sql(int procedure, Vector<String> parameters)
    {
    	String proc_name = Procedures.get(procedure);
    	String sql = "{call "+proc_name+"("+StringUtil.join(parameters,",")+")}";
		return sql;
	}

	public void rollback() throws SQLException
    {
        connection.setAutoCommit(false);
        connection.rollback();
        connection.setAutoCommit(true);
    }
    public void commit() throws SQLException
    {
        connection.setAutoCommit(false);
        connection.commit();
        connection.setAutoCommit(true);
    }
    public void begin() throws SQLException
    {
        run_query("begin", true);
    }
    
    private ProcedureResponse resultsetToList(ResultSet result) throws SQLException
    {
    	ProcedureResponse response = new ProcedureResponse();
    	
    	ResultSetMetaData rsMeta = result.getMetaData();
    	
    	List<List<Object>> data = new ArrayList<List<Object>>();
    	List<String> fields = new ArrayList<String>();
    	
    	for(int i = 0; i < rsMeta.getColumnCount(); i++)
        {
            fields.add(rsMeta.getColumnName(i+1));
        }
    	
    	while(result.next())
    	{
    		ArrayList<Object> linha = new ArrayList<Object>();
    		for(int i = 0; i < rsMeta.getColumnCount(); i++)
            {
                linha.add(result.getObject(i+1));//arg0))novoRegistro.set(rsMeta.getColumnName(i), lista.getObject(rsMeta.getColumnName(i)));
            }
    		data.add(linha);
    	}
    	response.data = data;
    	response.fields = fields;
    	
    	return response;
    }
    
}
