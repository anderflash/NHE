package br.poli.ecomp.geav.nhe.model.db.act{	import br.poli.ecomp.geav.nhe.model.db.atp.IActionType;	import br.poli.ecomp.geav.nhe.model.db.mdl.IModel;	import br.poli.ecomp.geav.nhe.model.db.ptc.IParticipation;		import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;	public class Action implements IAction{		private var _act_identificador:Number;		private var _ptc_identificador:IParticipation;		private var _atp_identificador:IActionType;		private var _act_parent:IAction;		private var _act_date_current:String;		private var _mdl_identificador:IModel;		public function Action(){}		public function get act_identificador():Number		{			return _act_identificador;		}		public function get ptc_identificador():IParticipation		{			return _ptc_identificador;		}		public function get atp_identificador():IActionType		{			return _atp_identificador;		}		public function get act_parent():IAction		{			return _act_parent;		}		public function get act_date_current():String		{			return _act_date_current;		}		public function get mdl_identificador():IModel		{			return _mdl_identificador;		}		public function set act_identificador(value:Number):void		{			this._act_identificador=value;		}		public function set ptc_identificador(value:IParticipation):void		{			this._ptc_identificador=value;		}		public function set atp_identificador(value:IActionType):void		{			this._atp_identificador=value;		}		public function set act_parent(value:IAction):void		{			this._act_parent=value;		}		public function set act_date_current(value:String):void		{			this._act_date_current=value;		}		public function set mdl_identificador(value:IModel):void		{			this._mdl_identificador=value;		}		public function get identificador():Number		{			return act_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
