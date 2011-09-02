package br.poli.ecomp.geav.nhe.model.db.acd{	import br.poli.ecomp.geav.nhe.model.db.act.IAction;	import br.poli.ecomp.geav.nhe.model.db.por.IPort;		import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;	public class ActionDisconnect implements IActionDisconnect{		private var _acd_identificador:Number;		private var _act_identificador:IAction;		private var _por_origin:IPort;		private var _por_destiny:IPort;		public function ActionDisconnect(){}		public function get acd_identificador():Number		{			return _acd_identificador;		}		public function get act_identificador():IAction		{			return _act_identificador;		}		public function get por_origin():IPort		{			return _por_origin;		}		public function get por_destiny():IPort		{			return _por_destiny;		}		public function set acd_identificador(value:Number):void		{			this._acd_identificador=value;		}		public function set act_identificador(value:IAction):void		{			this._act_identificador=value;		}		public function set por_origin(value:IPort):void		{			this._por_origin=value;		}		public function set por_destiny(value:IPort):void		{			this._por_destiny=value;		}		public function get identificador():Number		{			return acd_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
