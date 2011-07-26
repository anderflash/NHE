package br.poli.ecomp.geav.nhe.model.db;

import java.util.Vector;

/**
 * Class for Procedures
 * @author atavares
 *
 */
public class Procedures
{
	public static int ACT_SEARCH = 0;
	public static int CMP_SEARCH = 1;
	public static int PFL_SEARCH = 2;
	public static int PRO_SEARCH = 3;
	public static int PTC_SEARCH = 4;
	public static int ATP_SEARCH = 5;
	public static int USR_SEARCH = 6;
	public static int USR_LOGIN = 7;
	public static int PRO_CREATE = 8;
	public static int PTC_CREATE = 9;
	public static int PRO_SEARCH_USR = 10;
	
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
		
			prl_procedures.add("procedure_act_search");
			prl_procedures.add("procedure_cmp_search");
			prl_procedures.add("procedure_pfl_search");
			prl_procedures.add("procedure_pro_search");
			prl_procedures.add("procedure_ptc_search");
			prl_procedures.add("procedure_atp_search");
			prl_procedures.add("procedure_usr_search");
			prl_procedures.add("procedure_usr_login");
			prl_procedures.add("procedure_pro_create");
			prl_procedures.add("procedure_ptc_create");
			prl_procedures.add("procedure_pro_search_usr");
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
