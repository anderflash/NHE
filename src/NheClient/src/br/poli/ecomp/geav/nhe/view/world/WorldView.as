package br.poli.ecomp.geav.nhe.view.world
{
	import appkit.responders.NResponder;
	
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.materials.BitmapMaterial;
	import away3d.primitives.Plane;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import ru.inspirit.asfeat.calibration.IntrinsicParameters;
	
	public class WorldView extends Sprite
	{
		public static const WORLD_SIZE_MODIFIED:String = "WORLD_SIZE_MODIFIED";
		
		public static const VIEW_MINE:Number = 0;
		public static const VIEW_OWNER:Number = 1;
		
		private var _prl_view_3d:Vector.<View3D>;
		private var _prl_scene_3d:Vector.<Scene3D>;
		private var _prl_camera_3d:Vector.<ARAway3DCamera>;
		private var _prl_planes_3d:Vector.<Plane>;
		
		private var material:BitmapMaterial;
		private var webcam:Camera;
		private var video:Video;
		private var transformacao:Matrix;
		private var sprite:Sprite;
		
		private var _prn_num_views:Number = 2;
		
		public function WorldView()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, worldview_added_stage);
		}
		
		public function setup(intrinsic:IntrinsicParameters):void
		{
			prl_camera_3d = new Vector.<ARAway3DCamera>();
			prl_scene_3d = new Vector.<Scene3D>();
			prl_view_3d = new Vector.<View3D>();
			
			for(var i:uint = 0; i < _prn_num_views; i++)
			{
				prl_scene_3d.push(new Scene3D());
				prl_camera_3d.push(new ARAway3DCamera(intrinsic));
				prl_view_3d.push(new View3D(prl_scene_3d[i], prl_camera_3d[i]));
				prl_view_3d[i].width = 640;
				prl_view_3d[i].height = 480;
			}
			sprite = new Sprite();
			ajeitarFundo();
			//view.x = stage.stageWidth/2;
			//view.y = stage.stageHeight/2;
			webcam = Camera.getCamera();
			video = new Video(640,480);
			video.attachCamera(webcam);
			video.scaleX = -1;
			if(webcam)
			{
				prl_planes_3d = new Vector.<Plane>();
				for(i = 0; i < prn_num_views; i++)
				{
					 prl_planes_3d.push(new Plane(null,640,480));
					 prl_planes_3d[i].z = 1000;
					 prl_planes_3d[i].scaleX = 3.6;
					 prl_planes_3d[i].scaleY = prl_planes_3d[i].scaleX;
					 
					 var bitmapData:BitmapData = new BitmapData(1024,1024);
					 transformacao = new Matrix();
					 transformacao.scale(1024/video.width, 1024/video.height);

					 material = new BitmapMaterial(bitmapData);
					 material.repeat = true;
					 prl_planes_3d[i].material = material;

					 prl_scene_3d[i].addChild(prl_planes_3d[i]);
				}
			}
			addEventListener(Event.ADDED_TO_STAGE, added_to_stage_event);
			
		}
		
		private function added_to_stage_event(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added_to_stage_event);
			var stageResizeHandler:Function = function(e:Event):void
			{
				//removeChild(view);
				for(var i:uint = 0; i < 2; i++)
				{
					/*prl_view_3d[i].graphics.clear();
					prl_view_3d[i].graphics.beginFill(0xffffff);
					prl_view_3d[i].graphics.drawRect(0,0,Capabilities.screenResolutionX,Capabilities.screenResolutionY);
					prl_view_3d[i].graphics.endFill();
					prl_view_3d[i].backgroundColor = 0x000000;*/
					if(stage.displayState == StageDisplayState.FULL_SCREEN)
					{
						//plane.scaleX = 3.5 / 640 * Capabilities.screenResolutionX/2;
						//plane.scaleY = plane.scaleX;
						prl_view_3d[i].scaleX = (Capabilities.screenResolutionX - 100)/1280;
						prl_view_3d[i].scaleY = prl_view_3d[i].scaleX;
						trace(prl_view_3d[i].scaleX);
						//prl_view_3d[i].width = Capabilities.screenResolutionX/2;
						//prl_view_3d[i].height = Capabilities.screenResolutionY/2;
					}
					else
					{
						prl_view_3d[i].scaleX = 1;
						prl_view_3d[i].scaleY = 1;
						//plane.scaleX = 3.5;
						//plane.scaleY = plane.scaleX;
						//prl_view_3d[i].width = 640;
						//prl_view_3d[i].height = 480;
					}
					prl_view_3d[i].x = i * prl_view_3d[i].width * prl_view_3d[i].scaleX;
					prl_view_3d[i].render();
					//prl_view_3d[i].graphics.clear();
					ajeitarFundo();
				}
			};
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
			ajeitarFundo();
		}
		
		/*private function ajeitarFundo():void
		{
			sprite.x = 0;
			sprite.y = prl_view_3d[0].height;
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
		}*/
		
		public function view_show(view:Number):void
		{
			addChild(prl_view_3d[view]);
			if(stage)
				updateViewPositions();
		}
		
		public function view_hide(view:Number):void
		{
			if(prl_view_3d[view].parent == this)
				removeChild(prl_view_3d[view]);
			if(stage)
				updateViewPositions();
		}

		private function updateViewPositions():void
		{
			for(var i:uint = 0; i < _prn_num_views; i++)
			{
				if(prl_view_3d[i].parent)
				{
					prl_view_3d[i].x = i * prl_view_3d[i].width;
					prl_view_3d[i].y = 0;
					
				}
			}
		}
		
		public function render_start():void
		{
			addEventListener(Event.ENTER_FRAME, render_enter_frame);	
		}
		
		public function render_stop():void
		{
			removeEventListener(Event.ENTER_FRAME, render_enter_frame);
		}
		
		public function render_enter_frame(e:Event):void
		{
			for(var i:uint = 0; i < _prn_num_views; i++)
			{
				if(prl_view_3d[i].parent)
				{
					var bitmapOld:BitmapData = BitmapMaterial(prl_planes_3d[i].material).bitmapData;
					
					var bitmapData:BitmapData = new BitmapData(1024,1024);
					BitmapMaterial(prl_planes_3d[i].material).bitmapData = bitmapData;
					
					video.scaleX = -1;
					
					BitmapMaterial(prl_planes_3d[i].material).bitmapData.draw(video,transformacao);
					//BitmapMaterial(prl_planes_3d[i].material).scaleU = -1;
					prl_planes_3d[i].subMeshes[0].scaleU = -1;
					BitmapMaterial(prl_planes_3d[i].material).repeat = true;
					bitmapOld.dispose();
					prl_planes_3d[i].material = material;
					
					prl_view_3d[i].render();
				}
			}
			//plane.rotationY = (mouseX/(stage.stageWidth/2)+1) * 180;
		}
		
		public function get prn_num_views():Number
		{
			return _prn_num_views;
		}
		
		public function module_add():void
		{
			
		}
		
		public function module_remove():void
		{
			
		}
		
		public function module_move():void
		{
			
		}
		
		public function module_connect():void
		{
			
		}
		
		public function move_world(translation_matrix:Vector.<Number>, rotation_matrix:Vector.<Number>):void
		{
			
		}
		private function worldview_added_stage(e:Event):void
		{
			if(stage)
				updateViewPositions();
		}
		private function ajeitarFundo():void
		{
			sprite.x = 0;
			sprite.y = 0;
			sprite.graphics.beginFill(0xff0000,0);
			var barSize:Number = 90;
			
			if(stage)
			{
				if(stage.displayState == StageDisplayState.FULL_SCREEN)
					sprite.graphics.drawRect(0,0,Capabilities.screenResolutionX - barSize,prl_view_3d[0].height);
				else
					sprite.graphics.drawRect(0,0,Capabilities.screenResolutionX - barSize,prl_view_3d[0].height);
			}
			else
			{
				sprite.graphics.drawRect(0,0,Capabilities.screenResolutionX - barSize,prl_view_3d[0].height);
			}
			
			sprite.graphics.endFill();
			sprite.alpha = 0;
			sprite.mouseChildren = false;
			sprite.mouseEnabled = false;
			addChildAt(sprite,0);
			NResponder.dispatch(WORLD_SIZE_MODIFIED);
		}

		public function get prl_view_3d():Vector.<View3D>
		{
			return _prl_view_3d;
		}

		public function set prl_view_3d(value:Vector.<View3D>):void
		{
			_prl_view_3d = value;
		}

		public function get prl_scene_3d():Vector.<Scene3D>
		{
			return _prl_scene_3d;
		}

		public function set prl_scene_3d(value:Vector.<Scene3D>):void
		{
			_prl_scene_3d = value;
		}

		public function get prl_camera_3d():Vector.<ARAway3DCamera>
		{
			return _prl_camera_3d;
		}

		public function set prl_camera_3d(value:Vector.<ARAway3DCamera>):void
		{
			_prl_camera_3d = value;
		}

		public function get prl_planes_3d():Vector.<Plane>
		{
			return _prl_planes_3d;
		}

		public function set prl_planes_3d(value:Vector.<Plane>):void
		{
			_prl_planes_3d = value;
		}


	}
}