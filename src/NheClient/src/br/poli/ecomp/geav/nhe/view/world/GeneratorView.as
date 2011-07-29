package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.ObjectContainer3D;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.primitives.Cube;
	
	import br.poli.ecomp.geav.nhe.view.gui.AboutView;
	
	public class GeneratorView extends ObjectContainer3D
	{
		private var cube:Cube;
		
		public function GeneratorView(material:MaterialBase)
		{
			super();
			createShape(material);
		}
		
		private function createShape(material):void
		{
			cube = new Cube(material);
			addChild(cube);
		}
		
		private function changeColor(color:uint):void
		{
			var colormaterial:ColorMaterial = new ColorMaterial(color);
			cube.material = colormaterial;
		}
		
		private function duplicate():GeneratorView
		{
			var generatorview:GeneratorView = new Generator();
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
	}
}