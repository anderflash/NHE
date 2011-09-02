package br.poli.ecomp.geav.nhe.model.db.por{	import br.poli.ecomp.geav.nhe.model.db.mdl.IModel;		import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;	public class Port implements IPort{		private var _por_identificador:Number;		private var _mdl_identificador:IModel;		private var _por_description:String;		private var _por_in:Number;		private var _por_influencee:IPort;		public function Port(){}		public function get por_identificador():Number		{			return _por_identificador;		}		public function get mdl_identificador():IModel		{			return _mdl_identificador;		}		public function get por_description():String		{			return _por_description;		}		public function get por_in():Number		{			return _por_in;		}		public function get por_influencee():IPort		{			return _por_influencee;		}		public function set por_identificador(value:Number):void		{			this._por_identificador=value;		}		public function set mdl_identificador(value:IModel):void		{			this._mdl_identificador=value;		}		public function set por_description(value:String):void		{			this._por_description=value;		}		public function set por_in(value:Number):void		{			this._por_in=value;		}		public function set por_influencee(value:IPort):void		{			this._por_influencee=value;		}		public function get identificador():Number		{			return por_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
