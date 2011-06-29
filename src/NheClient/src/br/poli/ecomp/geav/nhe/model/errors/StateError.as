package br.poli.ecomp.geav.nhe.model.errors
{
	public class StateError extends Error
	{
		public static const NOT_CHILD_ERROR:Number = 1;
		public static const BEYOND_RANGE_ERROR:Number = 2;
		public static const NOT_ANCESTOR_ERROR:Number = 3;
		
		private var type:Number;
		
		public function StateError(type:Number, message:*="", id:*=0)
		{
			super(message, id);
			this.type = type;
		}
	}
}