package model.db.atp{	import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;

	public class ActionType implements IActionType{		private var _atp_identificador:Number;		private var _atp_nome:Number;		public function ActionType(){}		public function get atp_identificador():Number		{			return _atp_identificador;		}		public function get atp_nome():Number		{			return _atp_nome;		}		public function set atp_identificador(value:Number):void		{			this._atp_identificador=value;		}		public function set atp_nome(value:Number):void		{			this._atp_nome=value;		}		public function get identificador():Number		{			return atp_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
