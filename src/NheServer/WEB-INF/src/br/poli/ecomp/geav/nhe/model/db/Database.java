package br.poli.ecomp.geav.nhe.model.db;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class Database
{
	private HashMap<String, Repository> repositorios;
	private HashMap<String, Class<? extends Table>> classes;
	private HashMap<String, String> prefixos;

	public Database()
	{
		repositorios = new HashMap<String, Repository>();
		classes = new HashMap<String, Class<? extends Table>>();
		prefixos = new HashMap<String, String>();
	}

	public void adicionarRepositorio(String nome, String prefixo, Repository repositorio)
	{
		repositorios.put(nome,repositorio);
		classes.put(nome, repositorio.classe);
		prefixos.put(nome, prefixo);
	}

	public void removerRepositorio(String nome)
	{
		repositorios.remove(nome);
		classes.remove(nome);
		prefixos.remove(nome);
	}
		
	public void criarRepositorio(String prefixo, String nome, Class<? extends Table> classe)
	{
		repositorios.put(nome, new Repository(classe));
		classes.put(nome, classe);
		prefixos.put(nome, prefixo);
	}
	
	public Repository repositorio(String nome)
	{
		return repositorios.get(nome);
	}

	public String prefixo(String nome)
	{
		return prefixos.get(nome);
	}

	public Class<? extends Table> classe(String nome)
	{
		return classes.get(nome);
	}

	public String nomeFromPrefixo(String prefixo)
	{
		for (Map.Entry<String, String> entry: prefixos.entrySet())
		{
			if(entry.getValue() == prefixo) return entry.getKey();
		}
		return null;
	}
	
	public String nomeFromClasse(Class<? extends Table> classe)
	{
		for (Map.Entry<String, Class<? extends Table>> entry: classes.entrySet())
		{
			if(entry.getValue().equals(classe)) return entry.getKey();
		}
		return null;
	}
	
	public void fromResultSet(ResultSet result, String nome) throws InstantiationException, IllegalAccessException, SQLException, IllegalArgumentException, SecurityException, InvocationTargetException, NoSuchMethodException, RepositoryException
	{
		Class<? extends Table> classe = classes.get(nome);
		String prefix = prefixos.get(nome);
		
		result.beforeFirst();
		while(result.next())
		{
			ITable objTmp = classe.newInstance();
			classe.getMethod("set_" + prefix + "_identificador").invoke(objTmp, result.getInt(prefix + "_identificador"));
			objTmp = repositorios.get(nome).adicionarComCuidado(objTmp);
			ResultSetMetaData metaData = result.getMetaData();
			for(int i = 0; i < metaData.getColumnCount(); i++)
			{
				String prefixo = metaData.getColumnName(i).substring(0,3);
				if(!prefixo.equals(prefix))
				{
					Class<? extends Table> outraClasse = classes.get(nomeFromPrefixo(prefixo));
					ITable outroObj = outraClasse.newInstance();
					outraClasse.getMethod("set_" + prefixo + "_identificador").invoke(outroObj, result.getInt(prefixo + "_identificador"));
					
					outroObj = repositorios.get(nome).adicionarComCuidado(outroObj);
					classe.getMethod("set_" + metaData.getColumnName(i)).invoke(objTmp, outroObj);
				}
				else
				{
					Method method = classe.getMethod("set_" + metaData.getColumnName(i));
					classe.getMethod("set_" + metaData.getColumnName(i)).invoke(objTmp, method.getParameterTypes()[0].cast(result.getObject(i)));
				}
				
			}
		/*var objRef:IMZTable = new classes[nome]() as IMZTable;
		var xmlRef:XML = describeType(objRef);
		
		for each(var dataXML:XML in xml.data)
		{
			var objTmp:IMZTable = new classes[nome]() as IMZTable;
			objTmp[prefixos[nome]+"_identificador"] = dataXML[prefixos[nome]+"_identificador"];
			objTmp = Repository(repositorios[nome]).adicionarComCuidado(objTmp);
			
			for each(var accessorXML:XML in xmlRef.accessor)
			{
				if(accessorXML.@name != "identificador")
				{
					var prefixoSub:String = String(accessorXML.@name).substr(0,3);
					
					if(prefixos[nome] != prefixoSub)
					{
						var outroObj:IMZTable = new classes[nomeFromPrefixo(prefixoSub)]() as IMZTable;
						outroObj[prefixoSub+"_identificador"] = dataXML[accessorXML.@name];
						
						outroObj = Repository(repositorios[nomeFromPrefixo(prefixoSub)]).adicionarComCuidado(outroObj);
						objTmp[accessorXML.@name] = outroObj;
					}
					else
					{
						objTmp[accessorXML.@name] = dataXML[accessorXML.@name];
					}
					//if(nome == "MauMau")
					//	trace(accessorXML.@name, accessorXML.@type, getDefinitionByName(accessorXML.@type), dataXML[accessorXML.@name], objTmp[accessorXML.@name]);
				}
			}
			//if(nome == "Piso")
			//	trace(accessorXML.@name, accessorXML.@type, getDefinitionByName(accessorXML.@type), dataXML[accessorXML.@name], objTmp[accessorXML.@name]);*/
		}
	}
}