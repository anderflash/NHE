package br.poli.ecomp.geav.nhe.model.db.aco{	import br.poli.ecomp.geav.nhe.model.db.act.IAction;	import br.poli.ecomp.geav.nhe.model.db.por.IPort;		import marcozero.marzsdk.net.db.IMZTable;	public interface IActionConnect extends IMZTable	{		function set aco_identificador(value:Number):void;		function set act_identificador(value:IAction):void;		function set por_origin(value:IPort):void;		function set por_destiny(value:IPort):void;		function get aco_identificador():Number;		function get act_identificador():IAction;		function get por_origin():IPort;		function get por_destiny():IPort;	}}
