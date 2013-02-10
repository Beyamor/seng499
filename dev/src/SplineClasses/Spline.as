package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Spline 
	{
		
		public var points:Vector.<Point>; 
		public function Spline(inputPoints:Vector.<Point>) 
		{
			points = inputPoints;
		}
		
		public function interpolate_for_t(t:Number):Point
		{
			if (points.lengt > 1)
			{
				var nextPoints:Vector.<Point> = new Vector.<Point>;
				for ( var i:int = 1; i < points.length; i++ )
				{
					nextPoints.push((points[i].add(t*(points[i].subtract(points[i-1].x)))));
				}
				var nextSpline:Spline = new Spline(nextPoints);
				return interpolate_for_t(t);
			}
			else
			{
				return(lastPoints[0]);
			}
		}
	}

}