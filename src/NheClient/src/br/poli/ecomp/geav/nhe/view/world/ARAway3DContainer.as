package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.containers.ObjectContainer3D;

	import flash.events.Event;
	import flash.geom.Matrix3D;

	/**
	 * @author Eugene Zatepyakin
	 */
	public class ARAway3DContainer extends ObjectContainer3D
	{
		public var maxLostCount:uint = 7;
		public var lostCount:uint = 0;
		public var detected:Boolean = false;
		
		protected const transformData:Vector.<Number> = new Vector.<Number>(16, true);
		public var newMatrix:Matrix3D = new Matrix3D();
		public var nextMatrix:Matrix3D = new Matrix3D();
		
		public function ARAway3DContainer()
		{
			super();
			
			visible = false;
		}
		
		public function setTransform(R:Vector.<Number>, t:Vector.<Number>, matrixError:Number, mirror:Boolean = false):void
		{
			getAway3DMatrix( transformData, R, t, mirror );
			newMatrix.rawData = transformData;
			nextMatrix.interpolateTo(newMatrix, 0.85);
			
			this.transform = nextMatrix;
			
			
			visible = true;
			detected = true;
			lostCount = 0;
		}
		
		public function lost():void
		{
			if(++lostCount == maxLostCount)
			{
				hideObject();
			}
		}
		
		public function hideObject(e:Event = null):void
		{
			visible = false;
			detected = false;
			nextMatrix.identity();
		}
		
		public function getAway3DMatrix(data:Vector.<Number>, R:Vector.<Number>, t:Vector.<Number>, mirror:Boolean = false):void
		{
			if (mirror) {
				data[0] = -R[0];
				data[1] = -R[3];
				data[2] = R[6];
				data[3] = 0.0;
				data[4] = R[1];
				data[5] = R[4];
				data[6] = -R[7];
				data[7] = 0.0;
				data[8] = R[2];
				data[9] = R[5];
				data[10] = -R[8];
				data[11] = 0.0;
				data[12] = -t[0];
				data[13] = -t[1];
				data[14] = t[2];
				data[15] = 1.0;
			} else {
				data[0] = R[0];
				data[1] = -R[3];
				data[2] = R[6];
				data[3] = 0.0;
				data[4] = R[1];
				data[5] = -R[4];
				data[6] = R[7];
				data[7] = 0.0;
				data[8] = -R[2];
				data[9] = R[5];
				data[10] = -R[8];
				data[11] = 0.0;
				data[12] = t[0];
				data[13] = -t[1];
				data[14] = t[2];
				data[15] = 1.0;
			}
		}
	}
}
