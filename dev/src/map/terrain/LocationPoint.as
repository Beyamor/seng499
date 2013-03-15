package map.terrain 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class LocationPoint implements LocationStructure 
	{
		private var point:Point;
		
		public function LocationPoint(x:int, y:int) 
		{
			this.point = new Point(x, y);
		}
		
		public function distanceToPoint(point:Point):Number
		{
			return Point.distance(this.point,point);
		}
		
		public function angleToPoint(point:Point):Number
		{
			var diff = this.point.subtract(point);
			return getAngleMultipleOf(diff,30);
		}
		
		//returns an angle that is a multiple of interval.  Assumes y is negative up and positive down.
		public function getAngleMultipleOf(diff:Point, interval:int):int
		{	
			var angle = 0;
			if (diff.x == 0)
			{
				if (diff.y > 0) angle = 270;
				else if (diff.y < 0) angle = 90;
			}
			else if(diff.y==0)
			{
				if ( diff.x > 0 ) angle = 0;
				else if ( diff.x < 0 ) angle = 180;
			}
			else 
			{
				var tmp_angle = Math.atan(Math.abs(diff.y) / Math.abs(diff.x)) * 180 / Math.PI;
				var rem = tmp_angle % interval;
				
				if (Math.floor(rem / Math.floor(interval / 2)) < 1) tmp_angle -= rem;
				else 												tmp_angle += interval - rem;
				
				var switch_var = 0
				if (diff.x > 0) switch_var += 1;
				if (diff.y > 0) switch_var += 2;
				
				switch(switch_var)
				{
					case 0:			//quadrant 2
						angle = 180 - tmp_angle;
						break;
					case 1:			//quadrant 1
						angle = 0 + tmp_angle;
						break;
					case 2:			//quadrant 3
						angle = 180 + tmp_angle;
						break;
					case 3:			//quadrant 4
						angle = 360 - tmp_angle;
						break;
				}		
			}
			return angle;
		}
	}
}