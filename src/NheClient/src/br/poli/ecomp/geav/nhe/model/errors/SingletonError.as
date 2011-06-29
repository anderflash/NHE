package br.poli.ecomp.geav.nhe.model.errors
{
	public class SingletonError extends Error
	{
		public function SingletonError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}