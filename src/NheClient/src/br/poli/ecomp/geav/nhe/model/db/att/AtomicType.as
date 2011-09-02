package br.poli.ecomp.geav.nhe.model.db.att{	import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;	public class AtomicType implements IAtomicType{		private var _att_identificador:Number;		private var _att_name:String;		private var _att_description:String;		public function AtomicType(){}		public function get att_identificador():Number		{			return _att_identificador;		}		public function get att_name():String		{			return _att_name;		}		public function get att_description():String		{			return _att_description;		}		public function set att_identificador(value:Number):void		{			this._att_identificador=value;		}		public function set att_name(value:String):void		{			this._att_name=value;		}		public function set att_description(value:String):void		{			this._att_description=value;		}		public function get identificador():Number		{			return att_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
