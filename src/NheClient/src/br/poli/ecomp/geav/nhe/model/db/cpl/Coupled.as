package br.poli.ecomp.geav.nhe.model.db.cpl{	import br.poli.ecomp.geav.nhe.model.db.mdl.IModel;		import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;	public class Coupled implements ICoupled{		private var _cpl_identificador:Number;		private var _cpl_description:String;		private var _mdl_identificador:IModel;		public function Coupled(){}		public function get cpl_identificador():Number		{			return _cpl_identificador;		}		public function get cpl_description():String		{			return _cpl_description;		}		public function get mdl_identificador():IModel		{			return _mdl_identificador;		}		public function set cpl_identificador(value:Number):void		{			this._cpl_identificador=value;		}		public function set cpl_description(value:String):void		{			this._cpl_description=value;		}		public function set mdl_identificador(value:IModel):void		{			this._mdl_identificador=value;		}		public function get identificador():Number		{			return cpl_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
