package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.ObjectContainer3D;
	import away3d.materials.MaterialBase;
	import away3d.primitives.Cube;
	
	public class EraserView extends ModelView
	{
		private var cubeRed:Cube;
		private var cubeBlue:Cube;
		
		public function EraserView()
		{
			super();
			cubeRed = new Cube();
			cubeBlue= new Cube();
			addChild(cubeRed);
			addChild(cubeBlue);
		}
	}
}