package br.poli.ecomp.geav.nhe.model.db;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;

public interface ITable extends Comparable<ITable>
{
	int get_identificador();
	Boolean matches(ITable elemento);
	Boolean matchesAll(ITable elemento, Boolean operation, HashMap<String, Integer> operators) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException;
}
