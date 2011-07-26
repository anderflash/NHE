
package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.events.MouseEvent3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.LightBase;
	import away3d.lights.PointLight;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Cone;
	import away3d.primitives.Cube;
	import away3d.primitives.Plane;
	import away3d.primitives.Sphere;
	
	import br.poli.ecomp.geav.nhe.view.gui.AboutView;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BevelFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ARWorldTestView extends Sprite
	{
		private var view:View3D;
		private var scene:Scene3D;
		private var cube:Cube;
		private var sphere:Sphere;
		private var cone:Cone;
		private var pointLight:DirectionalLight;
		private var container:ObjectContainer3D;
		private var menuEsquerda:ObjectContainer3D;
		private var menuDireita:ObjectContainer3D;
		private const spaceBetweenPrimitives:Number = 10;
		private var texto:TextField;
		private var textoBitmap:BitmapData;
		
		private var balao:Plane;
		
		[SWF(frameRate = "60")]
		public function ARWorldTestView()
		{
			super();
			createBalao();
			view = new View3D();
			view.antiAlias = 4;
			addChild(view);			
			
			var colorMaterial:ColorMaterial = new ColorMaterial(0xff0000);
			
			
			
			cube = new Cube(colorMaterial,100,100,100,11,7,25,false);
			sphere = new Sphere(colorMaterial);
			cone = new Cone(colorMaterial,50,50);
			cube.z = sphere.radius + spaceBetweenPrimitives + cube.depth/2;
			cone.z = -sphere.radius - spaceBetweenPrimitives - cone.radius;
			
			pointLight = new DirectionalLight();
			/*pointLight.x = 0;
			pointLight.y = 1000;
			pointLight.z = 0;*/
			pointLight.color = 0xffeeaa;
			
			colorMaterial.lights = [pointLight];
			//bitmapMaterial.lights = [pointLight];
			container = new ObjectContainer3D();
			menuEsquerda = new ObjectContainer3D();
			menuDireita = new ObjectContainer3D();
			
			cone.addEventListener(MouseEvent3D.MOUSE_OVER, coneMouseOverEvent);
			cone.addEventListener(MouseEvent3D.MOUSE_OUT, coneMouseOutEvent);
			cube.addEventListener(MouseEvent3D.MOUSE_OVER, coneMouseOverEvent);
			cube.addEventListener(MouseEvent3D.MOUSE_OUT, coneMouseOutEvent);
			sphere.addEventListener(MouseEvent3D.MOUSE_OVER, coneMouseOverEvent);
			sphere.addEventListener(MouseEvent3D.MOUSE_OUT, coneMouseOutEvent);
			
			cone.mouseEnabled = true;
			cube.mouseEnabled = true;
			sphere.mouseEnabled = true;
			
			
			
			menuEsquerda.addChild(cube);
			menuEsquerda.addChild(sphere);
			menuEsquerda.addChild(cone);
			menuEsquerda.x = -200;
			container.addChild(menuEsquerda);
			view.scene.addChild(container);
			
			view.scene.addChild(pointLight);
			
			
			//var bitmap:Bitmap = new Bitmap(textoBitmap);
			//addChild(bitmap);
			
			
			
			view.width = stage.stageWidth;
			view.height = stage.stageHeight;

			addEventListener(Event.ENTER_FRAME, enterFrameEvent);
		}
		private function enterFrameEvent(e:Event):void
		{
			menuEsquerda.rotationY += 1;
			balao.rotationY = -menuEsquerda.rotationY;
			if(view.stage)
				view.render();
		}
		
		private function coneMouseOverEvent(e:Event):void
		{
			trace("coneMouseOverEvent");
			placeBalao(e.currentTarget as Object3D);
		}
		public function coneMouseOutEvent(e:Event):void
		{
			trace("coneMouseOutEvent");
			hideBalao();
		}
		private function createBalao():void
		{
			balao = new Plane(null,200,100,20,20);
			
		}
		
		private function placeBalao(objeto:Object3D):void
		{
			balao.x = objeto.x;
			var altura:Number = 0;
			var textoString:String;
			if(objeto is Cube)
			{
				altura = Cube(objeto).height;
				textoString = "Adicionar\nGerador";
			}
			else if(objeto is Sphere)
			{
				altura = Sphere(objeto).radius*2;
				textoString = "Adicionar\nProcessador";
			}
			else if(objeto is Cone)
			{
				altura = Cone(objeto).height;
				textoString = "Adicionar\nConsumidor";
			}
			balao.y = objeto.y + altura;
			balao.z = objeto.z;
			menuEsquerda.addChild(balao);
			if(!texto)
			{
				
				texto = new TextField();
				texto.autoSize = TextFieldAutoSize.LEFT;
				texto.multiline = true;
				var formato:TextFormat = new TextFormat();
				formato.color = 0x00ff00;
				formato.bold = true;
				formato.size = 50;
				//texto.background = true;
				//texto.backgroundColor = 0xffffff;
				texto.setTextFormat(formato);
				texto.defaultTextFormat = formato;
				texto.filters = [new BevelFilter()];
			}

			texto.text = textoString;
			//texto.x = texto.width/2;
			textoBitmap = new BitmapData(512, 512,true,0xffffff);
			var matrix:Matrix = new Matrix();
			trace(texto.width, texto.height);
			matrix.scale(512/texto.width,512/texto.width);
			textoBitmap.draw(texto,matrix,null,null,null,true);
			var bitmapMaterial:BitmapMaterial = new BitmapMaterial(textoBitmap);
			bitmapMaterial.ambientColor = 0x080820;
			bitmapMaterial.diffuseMethod.alphaThreshold = .25;
			bitmapMaterial.transparent = true;
			balao.material = bitmapMaterial;
			menuEsquerda.addChild(balao);
		}
		private function hideBalao():void
		{
			if(balao.parent)
				balao.parent.removeChild(balao);
		}
	}
}