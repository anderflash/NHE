package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Sphere;

	public class ProcessorView extends ModelView
	{
		private var shape:Sphere;
		public function ProcessorView()
		{
			
			super();
			shape = new Sphere();
			shape.material = new ColorMaterial(0xff0000);
			addChild(shape);
		}
	}
}