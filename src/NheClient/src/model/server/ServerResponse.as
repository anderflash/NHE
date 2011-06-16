package model.server
{
	public class ServerResponse
	{
		private var _prn_response_id:Number;
		private var _prn_function_id:Number;
		private var _prn_parameters:Vector.<String>;
		
		public function ServerResponse(data:String)
		{
			fill_response(data);
		}
		
		public function get prn_parameters():Vector.<String>
		{
			return _prn_parameters;
		}

		public function get prn_function_id():Number
		{
			return _prn_function_id;
		}

		public function get prn_response_id():Number
		{
			return _prn_response_id;
		}

		/**
		 * Fill the data of the response
		 * Fill the response id
		 * Fill the function id
		 * Fill the parameters 
		 * @param data
		 * 
		 */
		private function fill_response(data:String):void
		{
			
			var fields:Array = data.split(ServerDefaults.SEPARATOR_FIELDS);
			
			
			_prn_response_id = Number(fields[0]);
			_prn_function_id = Number(fields[i]);
			
			_prn_parameters = new Vector.<String>();
			for(var i:uint = 0; i < fields.length - 2; i++)
			{
				_prn_parameters.push(fields[i+2]);
			}
		}
	}
}