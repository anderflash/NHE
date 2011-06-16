package view
{
	import away3d.cameras.SpringCam;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.math.Vector3DUtils;
	import away3d.lights.PointLight;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.ColorMaterial;
	import away3d.materials.VideoMaterial;
	import away3d.primitives.Cube;
	import away3d.primitives.Plane;
	
	import flash.display.BitmapData;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.media.Camera;
	import flash.media.StageVideo;
	import flash.media.StageVideoAvailability;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	
	[SWF(frameRate="60", width="1280",height="860")]
	public class ARWorld extends Sprite
	{
		private var listViews:Vector.<View3D>;
		private var plane:Plane;
		private var material:BitmapMaterial;
		private var webcam:Camera;
		private var video:Video;
		private var transformacao:Matrix;
		private var sprite:Sprite;
		
		
		public function ARWorld()
		{
			if(stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			listViews = new Vector.<View3D>();
			var scene:Scene3D = new Scene3D();
			
			for(var i:uint = 0; i < 2; i++)
			{
				listViews.push(new View3D(scene));
				listViews[i].backgroundColor = 0xffffff;
				addChild(listViews[i]);
				listViews[i].width = 640;
				listViews[i].height = 480;
				listViews[i].x = i * listViews[i].width;
			}
			sprite = new Sprite();
			ajeitarFundo();
			//view.x = stage.stageWidth/2;
			//view.y = stage.stageHeight/2;
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			webcam = Camera.getCamera();
			video = new Video(640,480);
			video.attachCamera(webcam);
			video.scaleX = -1;
			if(webcam)
			{
				webcam.addEventListener(ActivityEvent.ACTIVITY, webcamActivity);
				
				plane = new Plane(null,640,480);
				plane.z = 1000;
				
				plane.scaleX = 3.6;
				plane.scaleY = plane.scaleX;
				
				var bitmapData:BitmapData = new BitmapData(1024,1024);
				transformacao = new Matrix();
				transformacao.scale(1024/video.width, 1024/video.height);
				
				material = new BitmapMaterial(bitmapData);
				material.repeat = true;
				plane.material = material;
				
				scene.addChild(plane);
				
			}
			var botao:Sprite = new Sprite();
			botao.graphics.beginFill(0x00ffff);
			botao.graphics.drawRoundRect(0,0,150,50,10,10);
			botao.graphics.endFill();
			addChild(botao);
			var texto:TextField = new TextField();
			var formato:TextFormat = new TextFormat();
			formato.color = 0xffffff;
			texto.autoSize = TextFieldAutoSize.CENTER;
			texto.defaultTextFormat = formato;
			texto.setTextFormat(formato);
			texto.x = (botao.width - texto.width)/2;
			texto.y = (botao.height - texto.height)/2;
			botao.addChild(texto);
			botao.buttonMode = true;
			var botaoHandle:Function = function(e:MouseEvent):void
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
			};
			botao.addEventListener(MouseEvent.CLICK, botaoHandle);
			
			var stageResizeHandler:Function = function(e:Event):void
			{
				//removeChild(view);
				for(var i:uint = 0; i < 2; i++)
				{
					listViews[i].graphics.clear();
					listViews[i].graphics.beginFill(0xffffff);
					listViews[i].graphics.drawRect(0,0,Capabilities.screenResolutionX,Capabilities.screenResolutionY);
					listViews[i].graphics.endFill();
					listViews[i].backgroundColor = 0xffffff;
					if(stage.displayState == StageDisplayState.FULL_SCREEN)
					{
						//plane.scaleX = 3.5 / 640 * Capabilities.screenResolutionX/2;
						//plane.scaleY = plane.scaleX;
						listViews[i].scaleX = (Capabilities.screenResolutionX/2)/640;
						listViews[i].scaleY = listViews[i].scaleX;
						trace(listViews[i].scaleX);
						//listViews[i].width = Capabilities.screenResolutionX/2;
						//listViews[i].height = Capabilities.screenResolutionY/2;
					}
					else
					{
						listViews[i].scaleX = 1;
						listViews[i].scaleY = 1;
						//plane.scaleX = 3.5;
						//plane.scaleY = plane.scaleX;
						//listViews[i].width = 640;
						//listViews[i].height = 480;
					}
					listViews[i].x = i * listViews[i].width * listViews[i].scaleX;
					listViews[i].render();
					listViews[i].graphics.clear();
				}
				
				ajeitarFundo();
			};
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
		}
		private function ajeitarFundo():void
		{
			sprite.x = 0;
			sprite.y = listViews[0].height;
			sprite.graphics.beginFill(0xffffff);
			if(stage.displayState == StageDisplayState.FULL_SCREEN)
			{
				sprite.graphics.drawRect(0,0,Capabilities.screenResolutionX,Capabilities.screenResolutionY);
			}
			else
			{
				sprite.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			}
			sprite.graphics.endFill();
			addChildAt(sprite,0);
		}
		
		private function onEnterFrame(e:Event):void
		{
			//plane.rotationY = (mouseX/(stage.stageWidth/2)+1) * 180;
			var bitmapOld:BitmapData = BitmapMaterial(plane.material).bitmapData;
			
			var bitmapData:BitmapData = new BitmapData(1024,1024);
			BitmapMaterial(plane.material).bitmapData = bitmapData;
			
			video.scaleX = -1;
			
			BitmapMaterial(plane.material).bitmapData.draw(video,transformacao);
			BitmapMaterial(plane.material).scaleU = -1;
			BitmapMaterial(plane.material).repeat = true;
			bitmapOld.dispose();
			plane.material = material;
			for(var i:uint = 0; i < 2; i++)
			{
				listViews[i].render();
			}
			
		}
		private function webcamActivity(e:ActivityEvent):void
		{
			if(e.activating)
			{
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
	}
}