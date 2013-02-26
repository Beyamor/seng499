package map.terrain 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public interface LocationStructure 
	{
		function distanceToPoint(point:Point):Number;
		function angleToPoint(point:Point):Number;
	}
}