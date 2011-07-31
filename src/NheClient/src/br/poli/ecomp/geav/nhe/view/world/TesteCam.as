package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.View3D;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Sphere;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.media.Camera;
	import flash.media.Video;
	
	public class TesteCam extends Sprite
	{
		public function TesteCam()
		{
			super();
			var view:View3D = new View3D();
			view.width = stage.stageWidth;
			view.height = stage.stageHeight;
			addChild(view);
			view.scene.addChild(new PointLight());
			
			var cam:Camera = Camera.getCamera();
			cam.setMode(640,480,30);
			var video:Video = new Video(640,480);
			
			video.attachCamera(cam);
			
			var luz:PointLight = new PointLight();
			luz.y = 100;
			var workview:WorkView = new WorkView();
			view.scene.addChild(workview);
			view.scene.addChild(luz);
			
			workview.x = 0;
			workview.lights = [luz];
			
			addEventListener
			(
				Event.ENTER_FRAME,
				function(e:Event):void
				{
					var bitmap:BitmapData = new BitmapData(640,480);
					bitmap.draw(video);
					view.backgroundImage = bitmap;
					workview.rotationY++;
					view.render();
				}
			);
			
			
		}
	}
}