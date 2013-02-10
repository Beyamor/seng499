package  
{
	import flash.geom.Point;
	import SplineClasses.SplineTable;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Spline 
	{
		
		public var points:Vector.<Point>; 
		public var table:SplineTable;
		public function Spline(inputPoints:Vector.<Point>) 
		{
			points = inputPoints;
			build_table();
		}
		
		public funcion build_table()
		{
			var t:Number = 0.0;
			var arc_length:Number = 0.0;
			//TODO
			
			for (var i:int = 0; i < table.tuples.length * 10; i++ )
			{
				//TODO
				//table.add()
			}
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