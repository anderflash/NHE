package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.ObjectContainer3D;
	import away3d.materials.MaterialBase;
	import away3d.primitives.Cube;
	
	public class EraserView extends ObjectContainer3D
	{
		private var cubeRed:Cube;
		private var cubeBlue:Cube;
		
		public function EraserView(material:MaterialBase)
		{
			super();
			cubeRed = new Cube(material);
			cubeBlue= new Cube(material);
			addChild(cubeRed);
			addChild(cubeBlue);
		}
	}
}