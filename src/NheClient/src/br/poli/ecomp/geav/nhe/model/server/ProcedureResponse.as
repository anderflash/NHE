package br.poli.ecomp.geav.nhe.model.server
{
	public class ProcedureResponse
	{
		public var fields:Array;
		
		public var data:Array;
		
		public function ProcedureResponse()
		{
			
		}
		
		public function get(index:Number, field_name:String):Object
		{
			return data[index][fields.indexOf(field_name)];
		}
	}
}