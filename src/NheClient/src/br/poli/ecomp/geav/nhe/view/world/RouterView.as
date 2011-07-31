package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Cone;

	public class RouterView extends ModelView
	{
		private var shape:Cone;
		public function RouterView()
		{
			super();
			shape = new Cone();
			shape.material = new ColorMaterial(0x0000ff);
			addChild(shape);
		}
		override public function set lights(value:Array):void
		{
			shape.material.lights = value;
		}
	}
}