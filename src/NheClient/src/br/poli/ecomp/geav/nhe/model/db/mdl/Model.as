package br.poli.ecomp.geav.nhe.model.db.mdl{	import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;	public class Model implements IModel{		private var _mdl_identificador:Number;		public function Model(){}		public function get mdl_identificador():Number		{			return _mdl_identificador;		}		public function set mdl_identificador(value:Number):void		{			this._mdl_identificador=value;		}		public function get identificador():Number		{			return mdl_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
