package br.poli.ecomp.geav.nhe.model.db.usr{	import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;	public class User implements IUser{		private var _usr_identificador:Number;		private var _usr_name:String;		private var _usr_login:String;		private var _usr_password:String;		private var _usr_email:String;		public function User(){}		public function get usr_identificador():Number		{			return _usr_identificador;		}		public function get usr_name():String		{			return _usr_name;		}		public function get usr_login():String		{			return _usr_login;		}		public function get usr_password():String		{			return _usr_password;		}		public function get usr_email():String		{			return _usr_email;		}		public function set usr_identificador(value:Number):void		{			this._usr_identificador=value;		}		public function set usr_name(value:String):void		{			this._usr_name=value;		}		public function set usr_login(value:String):void		{			this._usr_login=value;		}		public function set usr_password(value:String):void		{			this._usr_password=value;		}		public function set usr_email(value:String):void		{			this._usr_email=value;		}		public function get identificador():Number		{			return usr_identificador;		}		public function matches(elemento:IMZTable):Boolean
		{
			if(getQualifiedClassName(elemento) == getQualifiedClassName(this))
			{
				if(IMZTable(elemento).identificador == identificador)
					return true;
				else
					return false;
			}
			else
			{
				return false;
			}
		}
		public function matchesAll(elemento:IMZTable, operacao:Boolean, operadores:Object):Boolean
		{
			return MZOperators.matchesAll(this,elemento,operacao,operadores);
		}	}}
