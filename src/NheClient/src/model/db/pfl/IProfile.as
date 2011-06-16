package model.db.pfl{	import marcozero.marzsdk.net.db.IMZTable;
		public interface IProfile extends IMZTable	{		function set pfl_identificador(value:Number):void;		function set pfl_descricao(value:Number):void;		function get pfl_identificador():Number;		function get pfl_descricao():Number;	}}
