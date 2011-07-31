package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.ObjectContainer3D;
	import away3d.materials.ColorMaterial;
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
			cubeRed.material = new ColorMaterial(0xff0000);
			cubeBlue.material = new ColorMaterial(0x0000ff);
			addChild(cubeRed);
			addChild(cubeBlue);
		}
		
		override public function set lights(value:Array):void
		{
			cubeRed.material.lights = value;
			cubeBlue.material.lights = value;
		}
	}
}