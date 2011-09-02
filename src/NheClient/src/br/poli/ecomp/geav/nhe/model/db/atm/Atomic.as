package br.poli.ecomp.geav.nhe.model.db.atm{	import br.poli.ecomp.geav.nhe.model.db.att.IAtomicType;	import br.poli.ecomp.geav.nhe.model.db.cpl.ICoupled;	import br.poli.ecomp.geav.nhe.model.db.mdl.IModel;		import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;	public class Atomic implements IAtomic{		private var _atm_identificador:Number;		private var _atm_description:String;		private var _att_identificador:IAtomicType;		private var _mdl_identificador:IModel;		private var _cpl_identificador:ICoupled;		public function Atomic(){}		public function get atm_identificador():Number		{			return _atm_identificador;		}		public function get atm_description():String		{			return _atm_description;		}		public function get att_identificador():IAtomicType		{			return _att_identificador;		}		public function get mdl_identificador():IModel		{			return _mdl_identificador;		}		public function get cpl_identificador():ICoupled		{			return _cpl_identificador;		}		public function set atm_identificador(value:Number):void		{			this._atm_identificador=value;		}		public function set atm_description(value:String):void		{			this._atm_description=value;		}		public function set att_identificador(value:IAtomicType):void		{			this._att_identificador=value;		}		public function set mdl_identificador(value:IModel):void		{			this._mdl_identificador=value;		}		public function set cpl_identificador(value:ICoupled):void		{			this._cpl_identificador=value;		}		public function get identificador():Number		{			return atm_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
