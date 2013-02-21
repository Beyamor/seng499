package map.terrain 
{
	import flash.display.FocusDirection;
	import flash.ui.KeyLocation;
	import hex.terrain.Terrain;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Feature 
	{
		
		private var location:LocationStructure;
		private var range:Number;
		private var terrain:Terrain;
		
		public function Feature() 
		{
			
		}
		
		public function isInRange(point:Point):Boolean
		{
			return location.distanceToPoint(point) < range;
		}
		
		public function getTerrainForce(point:Point):TerrainForce
		{
			return null;
		}
	}

}