package map.terrain 
{
	import flash.geom.Point;
	import hex.HexIndices;
	import hex.terrain.Terrain;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class TerrainForce 
	{
		private var direction:int;
		private var terrain:Terrain;
		private var rootHex:HexIndices;
		private var spread:int;
		private var decay:int;
		private var force:int;
		
		//Don't worry Tom, I'm planning a fluent constructor for this later.  This is just a stand in.
		public function TerrainForce(terrain:Terrain, direction:int, root:HexIndices, force:int, spread:int, decay:int) 
		{
			this.terrain = terrain;
			this.direction = direction;
			this.rootHex = root;
			this.spread = spread;
			this.decay = decay;
			this.force = force;
		}	
		
		//called when a terrain force is going to create a child.
		public function propegate():TerrainForce
		{
			return null;
		}
		
		//I need to think more about how these will work with our system.
		public function inSpread(hex:HexIndices):Boolean
		{
			return false;
		}
	}
}