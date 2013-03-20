package map.terrain 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public interface LocationStructure 
	{
		function distanceToPoint(x:int,y:int):Number;
		function angleToPoint(point:Point):Number;
	}
}