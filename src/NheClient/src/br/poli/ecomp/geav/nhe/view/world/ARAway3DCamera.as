package br.poli.ecomp.geav.nhe.view.world
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;

	import ru.inspirit.asfeat.calibration.IntrinsicParameters;

	import flash.geom.Matrix3D;

	/**
	 * @author Eugene Zatepyakin
	 */
	public class ARAway3DCamera extends Camera3D
	{
		protected var intrinsic:IntrinsicParameters;
		public const arProjectionMatrix:Matrix3D = new Matrix3D();
		
		public function ARAway3DCamera( intrinsic:IntrinsicParameters, viewportToSourceWidthRatio:Number = 1.0 )
		{
			super();
			
			this.intrinsic = intrinsic;
			
			arProjectionMatrix.rawData = getProjectionMatrix(viewportToSourceWidthRatio);
			
			lens = new PerspectiveLens();
			//this.zoom = 0.01 * arProjectionMatrix.rawData[0];
		}
		
		public function updateProjectionMatrix(viewportToSourceWidthRatio:Number = 1.0):void
        {
            arProjectionMatrix.rawData = getProjectionMatrix(viewportToSourceWidthRatio);
            //this.zoom = 0.01 * arProjectionMatrix.rawData[0];
        }
		
		protected function getProjectionMatrix(ratio:Number = 1.0):Vector.<Number>
		{
			return Vector.<Number>([
					intrinsic.fx*ratio,	0,	        		0,	    0,
                    0,          		intrinsic.fy*ratio,	0,	    0,
                    0,	        		0,	        		1,	    1,
                    0,		    		0,		    		0,	    0
				]);
		}
	}
}