package br.poli.ecomp.geav.nhe.model.db.cmp;import br.poli.ecomp.geav.nhe.model.db.ITable;import br.poli.ecomp.geav.nhe.model.db.pro.IProjeto;public interface IComposicao extends ITable{	void set_cmp_identificador(int value);	void set_pro_componente(IProjeto value);	void set_pro_projeto(IProjeto value);	void set_cmp_atual(int value);	int get_cmp_identificador();	IProjeto get_pro_componente();	IProjeto get_pro_projeto();	int get_cmp_atual();}
