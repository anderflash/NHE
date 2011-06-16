package model.db.ptc{	import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;		import model.db.pfl.IProfile;	import model.db.pro.IProject;	import model.db.usr.IUser;

	public class Participation implements IParticipation{		private var _ptc_identificador:Number;		private var _pro_identificador:IProject;		private var _usr_identificador:IUser;		private var _pfl_identificador:IProfile;		public function Participation(){}		public function get ptc_identificador():Number		{			return _ptc_identificador;		}		public function get pro_identificador():IProject		{			return _pro_identificador;		}		public function get usr_identificador():IUser		{			return _usr_identificador;		}		public function get pfl_identificador():IProfile		{			return _pfl_identificador;		}		public function set ptc_identificador(value:Number):void		{			this._ptc_identificador=value;		}		public function set pro_identificador(value:IProject):void		{			this._pro_identificador=value;		}		public function set usr_identificador(value:IUser):void		{			this._usr_identificador=value;		}		public function set pfl_identificador(value:IProfile):void		{			this._pfl_identificador=value;		}		public function get identificador():Number		{			return ptc_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
