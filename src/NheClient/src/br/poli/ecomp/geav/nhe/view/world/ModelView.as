package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.ObjectContainer3D;
	
	public class ModelView extends ObjectContainer3D
	{
		private var _pao_shape:ObjectContainer3D;
		
		public function ModelView()
		{
			super();
		}

		public function get pao_shape():ObjectContainer3D
		{
			return _pao_shape;
		}

		public function set pao_shape(value:ObjectContainer3D):void
		{
			_pao_shape = value;
		}

	}
}