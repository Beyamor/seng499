package map.terrain 
{
	//import flash.display.FocusDirection; //what does this do?  I think Imight have added it by accident
	import flash.geom.Point;
	import map.terrain.LocationStructure;
	import hex.terrain.Terrain;
	import net.flashpunk.graphics.Image;
	import hex.HexIndices;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Feature 
	{
		
		private var location:LocationStructure;
		private var range:Number;
		private var terrain:Terrain;
		private var _mapImage:Image;
		private var spread:int;
		private var initialForce:int;
		public var x:int;
		public var y:int;
		
		
		//we'll eventually need a fluent setup for this too.
		public function Feature(location:LocationStructure, range:Number, terrain:Terrain, mapImage:Image, force:int, spread:int, x:int, y:int) 
		{
			this.location = location;
			this.range = range;
			this.terrain = terrain;
			this._mapImage = mapImage;
			this.spread = spread;
			this.initialForce = force;
			this.x = x;
			this.y = y;
		}
		
		public function isInRange(point:Point):Boolean
		{
			return location.distanceToPoint(point) < range;
		}
		
		public function getTerrainForce(indecies:HexIndices):TerrainForce
		{
			return new TerrainForce( terrain, location.angleToPoint(new Point(indecies.x,indecies.y)),  initialForce, spread);
		}
		
		public function get mapImage():Image
		{
			return _mapImage;
		}
	}

}