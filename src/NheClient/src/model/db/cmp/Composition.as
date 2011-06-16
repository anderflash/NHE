package model.db.cmp{	import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;		import model.db.pro.IProject;
		public class Composition implements IComposition	{		private var _cmp_identificador:Number;		private var _pro_componente:IProject;		private var _pro_projeto:IProject;		private var _cmp_atual:Number;				public function Composition()		{		}				public function get cmp_identificador():Number		{			return _cmp_identificador;		}		public function get pro_componente():IProject		{			return _pro_componente;		}		public function get pro_projeto():IProject		{			return _pro_projeto;		}		public function get cmp_atual():Number		{			return _cmp_atual;		}		public function set cmp_identificador(value:Number):void		{			this._cmp_identificador=value;		}		public function set pro_componente(value:IProject):void		{			this._pro_componente=value;		}		public function set pro_projeto(value:IProject):void		{			this._pro_projeto=value;		}		public function set cmp_atual(value:Number):void		{			this._cmp_atual=value;		}		public function get identificador():Number		{			return cmp_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
