package br.poli.ecomp.geav.nhe.view.augmentedreality
{
	import flash.display.Sprite;
	
	public class ARView extends Sprite
	{
		// camera size
		public var camWidth:int = 640;
		public var camHeight:int = 480;
		public var downScaleRatio:Number = 1; // better leave it as it is
		public var srcWidth:int = 640; // should be the same as camera size untill downscale is used
		public var srcHeight:int = 480;
		public var maxPointsToDetect:int = 300; // max point to allow on the screen
		public var maxReferenceObjects:int = 6; // max reference objects to be used
		public var mirror:Boolean = true; // mirror camera output
		
		public function ARView()
		{
			super();
		}
	}
}