package br.poli.ecomp.geav.nhe.model.db.pot{	import br.poli.ecomp.geav.nhe.model.db.att.IAtomicType;		import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;	public class PortType implements IPortType{		private var _pot_identificador:Number;		private var _att_identificador:IAtomicType;		private var _pot_description:String;		private var _pot_in:Number;		public function PortType(){}		public function get pot_identificador():Number		{			return _pot_identificador;		}		public function get att_identificador():IAtomicType		{			return _att_identificador;		}		public function get pot_description():String		{			return _pot_description;		}		public function get pot_in():Number		{			return _pot_in;		}		public function set pot_identificador(value:Number):void		{			this._pot_identificador=value;		}		public function set att_identificador(value:IAtomicType):void		{			this._att_identificador=value;		}		public function set pot_description(value:String):void		{			this._pot_description=value;		}		public function set pot_in(value:Number):void		{			this._pot_in=value;		}		public function get identificador():Number		{			return pot_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
