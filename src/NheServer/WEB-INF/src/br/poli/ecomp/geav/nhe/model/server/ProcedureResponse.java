package br.poli.ecomp.geav.nhe.model.server;

import java.util.ArrayList;
import java.util.List;

public class ProcedureResponse
{
	public List<String> fields;
	
	public List<List<Object>> data;
	public ProcedureResponse()
	{
		fields = new ArrayList<String>();
		data = new ArrayList<List<Object>>();
	}
}
