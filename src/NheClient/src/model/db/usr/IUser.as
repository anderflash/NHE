package model.db.usr{	import marcozero.marzsdk.net.db.IMZTable;
		public interface IUser extends IMZTable	{		function set usr_identificador(value:Number):void;		function set usr_nome(value:Number):void;		function set usr_login(value:String):void;		function set usr_senha(value:String):void;		function set usr_email(value:String):void;		function get usr_identificador():Number;		function get usr_nome():Number;		function get usr_login():String;		function get usr_senha():String;		function get usr_email():String;	}}
