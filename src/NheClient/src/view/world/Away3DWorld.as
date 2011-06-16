package view.world
{
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	import ru.inspirit.asfeat.calibration.IntrinsicParameters;
	
	/**
	 * @author Anderson Tavares
	 */
	public final class Away3DWorld extends Sprite
	{
		public var view3d:View3D;
		public var camera3d:ARAway3DCamera;
		public var scene3d:Scene3D;
		
		public var light:DirectionalLight3D;
		
		public function Away3DWorld(intrinsic:IntrinsicParameters, viewportW:int = 640, viewportH:int = 480)
		{
			scene3d = new Scene3D();
			camera3d = new ARAway3DCamera( intrinsic, 1.0 );
			view3d = new View3D(
				{x:viewportW * 0.5, y:viewportH * 0.5, scene:scene3d, camera:camera3d}
			);
			
			this.addChild(view3d);
			
			this.light = new DirectionalLight3D();
			this.light.direction = new Vector3D(500, -300, 200);
			this.scene3d.addLight(light);
		}
		
		public function updateAROptions():void
		{
			camera3d.updateProjectionMatrix();
		}
		
		public function render(e:Event = null):void
		{			
			view3d.render();
		}
	}
}
