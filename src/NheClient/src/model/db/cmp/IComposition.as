package model.db.cmp{	import marcozero.marzsdk.net.db.IMZTable;		import model.db.pro.IProject;

	public interface IComposition extends IMZTable	{		function set cmp_identificador(value:Number):void;		function set pro_componente(value:IProject):void;		function set pro_projeto(value:IProject):void;		function set cmp_atual(value:Number):void;		function get cmp_identificador():Number;		function get pro_componente():IProject;		function get pro_projeto():IProject;		function get cmp_atual():Number;	}}
