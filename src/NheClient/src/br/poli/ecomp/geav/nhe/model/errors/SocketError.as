package br.poli.ecomp.geav.nhe.model.errors
{
	public class SocketError extends Error
	{
		public function SocketError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}