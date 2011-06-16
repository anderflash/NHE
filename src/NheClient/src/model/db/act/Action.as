package model.db.act{	import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;		import model.db.atp.IActionType;	import model.db.cmp.IComposition;	import model.db.ptc.IParticipation;
		public class Action implements IAction	{		private var _act_identificador:Number;		private var _ptc_identificador:IParticipation;		private var _atp_identificador:IActionType;		private var _act_pai:Number;		private var _cmp_identificador:IComposition;		private var _act_data_atual:String;				public function Action()		{		}		public function get act_identificador():Number		{			return _act_identificador;		}		public function get ptc_identificador():IParticipation		{			return _ptc_identificador;		}		public function get atp_identificador():IActionType		{			return _atp_identificador;		}		public function get act_pai():Number		{			return _act_pai;		}		public function get cmp_identificador():IComposition		{			return _cmp_identificador;		}		public function get act_data_atual():String		{			return _act_data_atual;		}		public function set act_identificador(value:Number):void		{			this._act_identificador=value;		}		public function set ptc_identificador(value:IParticipation):void		{			this._ptc_identificador=value;		}		public function set atp_identificador(value:IActionType):void		{			this._atp_identificador=value;		}		public function set act_pai(value:Number):void		{			this._act_pai=value;		}		public function set cmp_identificador(value:IComposition):void		{			this._cmp_identificador=value;		}		public function set act_data_atual(value:String):void		{			this._act_data_atual=value;		}		public function get identificador():Number		{			return act_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
