package model.db.atp{	import marcozero.marzsdk.net.db.IMZTable;
		public interface IActionType extends IMZTable	{		function set atp_identificador(value:Number):void;		function set atp_nome(value:Number):void;		function get atp_identificador():Number;		function get atp_nome():Number;	}}
