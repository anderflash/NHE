package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.ObjectContainer3D;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.primitives.Cube;
	
	import br.poli.ecomp.geav.nhe.view.gui.AboutView;
	
	public class GeneratorView extends ModelView
	{
		private var cube:Cube;
		
		public function GeneratorView()
		{
			super();
			createShape();
			changeColor(0xff0000);
		}
		
		private function createShape():void
		{
			cube = new Cube();
			addChild(cube);
		}
		
		private function changeColor(color:uint):void
		{
			var colormaterial:ColorMaterial = new ColorMaterial(color);
			cube.material = colormaterial;
		}
		
		private function duplicate():GeneratorView
		{
			var generatorview:GeneratorView = new GeneratorView();
			generatorview.cube = new Cube(
									new ColorMaterial(ColorMaterial(cube.material).color),
									cube.width, 
									cube.height, 
									cube.depth, 
									cube.segmentsW, 
									cube.segmentsH, 
									cube.segmentsD, 
									cube.tile6);
			return generatorview;
		}
		
		override public function set lights(value:Array):void
		{
			cube.material.lights = value;
		}
	}
}