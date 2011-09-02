package br.poli.ecomp.geav.nhe.model.db.atp{	import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;	public class ActionType implements IActionType{		private var _atp_identificador:Number;		private var _atp_name:String;		public function ActionType(){}		public function get atp_identificador():Number		{			return _atp_identificador;		}		public function get atp_name():String		{			return _atp_name;		}		public function set atp_identificador(value:Number):void		{			this._atp_identificador=value;		}		public function set atp_name(value:String):void		{			this._atp_name=value;		}		public function get identificador():Number		{			return atp_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
