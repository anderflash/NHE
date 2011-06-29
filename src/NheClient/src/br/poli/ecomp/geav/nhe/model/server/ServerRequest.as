package br.poli.ecomp.geav.nhe.model.server
{
	/**
	 * Class for  
	 * @author Anderson Tavares
	 * 
	 */
	public class ServerRequest
	{
		private var _pan_id:Number;
		private var _pan_usr_identificador:Number;
		private var _pas_func:Number;
		private var _pal_parameters:Vector.<String>;
		
		public function ServerRequest()
		{
			
		}
		
		/*------------------------------------
		* PUBLIC METHODS
		*-----------------------------------*/
		
		
		
		/*------------------------------------
		 * PROPERTIES
		 *-----------------------------------*/
		public function get pas_func():Number
		{
			return _pas_func;
		}

		public function set pas_func(value:Number):void
		{
			_pas_func = value;
		}

		public function get pal_parameters():Vector.<String>
		{
			return _pal_parameters;
		}

		public function set pal_parameters(value:Vector.<String>):void
		{
			_pal_parameters = value;
		}

		public function get pan_id():Number
		{
			return _pan_id;
		}

		public function set pan_id(value:Number):void
		{
			_pan_id = value;
		}

		public function get pan_usr_identificador():Number
		{
			return _pan_usr_identificador;
		}

		public function set pan_usr_identificador(value:Number):void
		{
			_pan_usr_identificador = value;
		}

		public function get text():String
		{
			return String(_pan_id) + ServerDefaults.SEPARATOR_FIELDS +
				   isNaN(_pan_usr_identificador)?"":String(_pan_usr_identificador) + String(_pas_func) + ServerDefaults.SEPARATOR_FIELDS + 
				   String(_pal_parameters.join(ServerDefaults.SEPARATOR_FIELDS));
		}
		
		/*------------------------------------
		* PRIVATE METHODS
		*-----------------------------------*/
		
		
		/*------------------------------------
		* EVENT HANDLERS
		*-----------------------------------*/

	}
}