package br.poli.ecomp.geav.nhe.model.db;

import java.util.Vector;

/**
 * Class for Procedures
 * @author atavares
 *
 */
public class Procedures
{
	public static int PROCURAR_ACA = 1;
	public static int PROCURAR_CMP = 2;
	public static int PROCURAR_PER = 3;
	public static int PROCURAR_PRO = 4;
	public static int PROCURAR_PTC = 5;
	public static int PROCURAR_TPA = 6;
	public static int PROCURAR_USU = 7;
	
	private static Vector<String> prl_procedures;
	
	public Procedures(){}
	
	/**
	 * Fill the procedures list once
	 */
	private static void fill_procedures()
	{
		if(prl_procedures == null)
		{
			prl_procedures = new Vector<String>();
		
			prl_procedures.add("PROCEDURE_PROCURAR_ACA");
			prl_procedures.add("PROCEDURE_PROCURAR_CMP");
			prl_procedures.add("PROCEDURE_PROCURAR_PER");
			prl_procedures.add("PROCEDURE_PROCURAR_PRO");
			prl_procedures.add("PROCEDURE_PROCURAR_PTC");
			prl_procedures.add("PROCEDURE_PROCURAR_TPA");
			prl_procedures.add("PROCEDURE_PROCURAR_USU");
		}
	}
	
	/**
	 * Get procedure from index. You should use the constants
	 * @param index
	 * @return
	 */
	public static String get(int index)
	{
		fill_procedures();
		return prl_procedures.get(index);
	} 
}
