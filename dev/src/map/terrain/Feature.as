package map.terrain 
{
	//import flash.display.FocusDirection; //what does this do?  I think Imight have added it by accident
	import flash.geom.Point;
	import map.terrain.LocationStructure;
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
		
		public function Feature(location:LocationStructure, range:Number, terrain:Terrain) 
		{
			this.location = location;
			this.range = range;
			this.terrain = terrain;
		}
		
		public function isInRange(point:Point):Boolean
		{
			return location.distanceToPoint(point) < range;
		}
		
		public function getTerrainForce(point:Point):TerrainForce
		{
			return new TerrainForce( terrain, location.angleToPoint(point));
		}
	}

}