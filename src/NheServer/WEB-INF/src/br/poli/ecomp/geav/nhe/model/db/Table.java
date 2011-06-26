package br.poli.ecomp.geav.nhe.model.db;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;

public class Table implements ITable
{
	public static Boolean AND = true;
	public static Boolean OR = false;
	
	public static final int GREATER_THAN = 1;
	public static final int SMALLER_THAN = 2;
	public static final int EQUAL = 3;
	public static final int GREATER_EQUAL = 4;
	public static final int SMALLER_EQUAL = 5;
	public static final int INEQUAL = 6;
	public static final int CONTAINS = 7;
	public static final int IS_CONTAINED = 8;
	
	protected Table()
	{
		
	}
	
	@Override
	public Boolean matches(ITable elemento) {
		if(getClass().equals(elemento.getClass()))
		{
			if(get_identificador() == elemento.get_identificador())
				return true;
			else
				return false;
		}
		return null;
	}
	
	@Override
	public Boolean matchesAll(ITable element, Boolean operation,
			HashMap<String, Integer> operators) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		// Só compara se forem de tabelas iguais
		if(getClass().equals(element.getClass()))
		{
			Boolean andValue = true;
			Boolean orValue = false;
			// Fazer reflexão (ler toda a tabela)
			Class<? extends Table> vrc_class = getClass();
			
			Method[] vrl_methods = vrc_class.getDeclaredMethods();
			
			for (int i = 0; i < vrl_methods.length; i++)
			{
				if(!operators.containsKey(vrl_methods[i].getName()))
				{
					continue;
				}
				else
				{
					if(compareTo(vrl_methods[i].invoke(this),vrl_methods[i].invoke(element),operators.get(vrl_methods[i].getName())))
						orValue = true;
					else
						andValue = false;
				}
			}
			
			return operation && andValue || !operation && orValue;
		}
		else
		{
			return false;
		}
	}
	
	private boolean compareTo(Object v1, Object v2, Integer operation) {
		
		switch(operation)
		{
			case GREATER_THAN:
				if(v1 instanceof String)
					return String.valueOf(v1).compareTo(String.valueOf(v2)) < 0;
				else if(v1 instanceof Integer)
					return Integer.valueOf(String.valueOf(v1)) < Integer.valueOf(String.valueOf(v2)); 
				break;
			case SMALLER_THAN:
				if(v1 instanceof String)
					return String.valueOf(v1).compareTo(String.valueOf(v2)) > 0;
				else if(v1 instanceof Integer)
					return Integer.valueOf(String.valueOf(v1)) > Integer.valueOf(String.valueOf(v2)); 
				break;
			case EQUAL: 
				if(v1 instanceof String)
					return String.valueOf(v1).compareTo(String.valueOf(v2)) == 0;
				else if(v1 instanceof Integer)
					return Integer.valueOf(String.valueOf(v1)) == Integer.valueOf(String.valueOf(v2));
				else
					return v1.equals(v2);
			case GREATER_EQUAL:
				if(v1 instanceof String)
					return String.valueOf(v1).compareTo(String.valueOf(v2)) >= 0;
				else if(v1 instanceof Integer)
					return Integer.valueOf(String.valueOf(v1)) >= Integer.valueOf(String.valueOf(v2)); 
				break;
			case SMALLER_EQUAL: 
				if(v1 instanceof String)
					return String.valueOf(v1).compareTo(String.valueOf(v2)) <= 0;
				else if(v1 instanceof Integer)
					return Integer.valueOf(String.valueOf(v1)) <= Integer.valueOf(String.valueOf(v2));
				else
					throw new IllegalAccessError();
				
			case INEQUAL:
				if(v1 instanceof String)
					return String.valueOf(v1).compareTo(String.valueOf(v2)) != 0;
				else if(v1 instanceof Integer)
					return Integer.valueOf(String.valueOf(v1)) != Integer.valueOf(String.valueOf(v2));
				else
					return !v1.equals(v2);
			case CONTAINS: 
				return String.valueOf(v1).indexOf(String.valueOf(v2)) != -1;
			case IS_CONTAINED:
				return String.valueOf(v1).indexOf(String.valueOf(v2)) != -1;
		}
		return false;
	}

	@Override
	public int get_identificador() {
		return 0;
	}

	@Override
	public int compareTo(ITable o) {
		// TODO Auto-generated method stub
		return 0;
	}
}
