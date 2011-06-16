package model.db.pro{	import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;		import model.db.act.IAction;

	public class Project implements IProject{		private var _pro_identificador:Number;		private var _pro_titulo:Number;		private var _pro_descricao:Number;		private var _pro_basico:Number;		private var _pro_finalizado:Number;		private var _aca_identificador:IAction;		public function Project(){}		public function get pro_identificador():Number		{			return _pro_identificador;		}		public function get pro_titulo():Number		{			return _pro_titulo;		}		public function get pro_descricao():Number		{			return _pro_descricao;		}		public function get pro_basico():Number		{			return _pro_basico;		}		public function get pro_finalizado():Number		{			return _pro_finalizado;		}		public function get aca_identificador():IAction		{			return _aca_identificador;		}		public function set pro_identificador(value:Number):void		{			this._pro_identificador=value;		}		public function set pro_titulo(value:Number):void		{			this._pro_titulo=value;		}		public function set pro_descricao(value:Number):void		{			this._pro_descricao=value;		}		public function set pro_basico(value:Number):void		{			this._pro_basico=value;		}		public function set pro_finalizado(value:Number):void		{			this._pro_finalizado=value;		}		public function set aca_identificador(value:IAction):void		{			this._aca_identificador=value;		}		public function get identificador():Number		{			return pro_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
