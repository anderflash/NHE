package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.ObjectContainer3D;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Cone;
	
	public class ConsumerView extends ModelView
	{
		private var shape:Cone;
		
		public function ConsumerView()
		{
			super();
			shape = new Cone(new ColorMaterial(0xff0000));
			addChild(shape);
		}
		override public function set lights(value:Array):void
		{
			shape.material.lights = value;
		}
	}
}