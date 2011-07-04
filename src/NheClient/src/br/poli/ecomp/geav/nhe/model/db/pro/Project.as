package br.poli.ecomp.geav.nhe.model.db.pro{	import br.poli.ecomp.geav.nhe.model.db.act.IAction;		import flash.utils.getQualifiedClassName;		import marcozero.marzsdk.net.db.IMZTable;	import marcozero.marzsdk.net.db.MZOperators;
	
	public class Project implements IProject	{		private var _pro_identificador:Number;		private var _pro_title:String;		private var _pro_description:Number;		private var _pro_primitive:Number;		private var _pro_finiished:Number;		private var _act_identificador:IAction;		private var _pro_model_path:String;				public function Project(){}				public function get pro_identificador():Number		{			return _pro_identificador;		}		public function get pro_title():String		{			return _pro_title;		}		public function get pro_description():Number		{			return _pro_description;		}		public function get pro_primitive():Number		{			return _pro_primitive;		}		public function get pro_finished():Number		{			return _pro_finiished;		}		public function get act_identificador():IAction		{			return _act_identificador;		}		public function set pro_identificador(value:Number):void		{			this._pro_identificador=value;		}		public function set pro_title(value:String):void		{			this._pro_title=value;		}		public function set pro_description(value:Number):void		{			this._pro_description=value;		}		public function set pro_primitive(value:Number):void		{			this._pro_primitive=value;		}		public function set pro_finished(value:Number):void		{			this._pro_finiished=value;		}		public function set act_identificador(value:IAction):void		{			this._act_identificador=value;		}		public function get identificador():Number		{			return pro_identificador;		}		public function matches(elemento:IMZTable):Boolean
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
		}		public function get pro_model_path():String		{			return _pro_model_path;		}				public function set pro_model_path(value:String):void		{			_pro_model_path = value;		}				public function toString():String		{			return this._pro_title;		}	}}
