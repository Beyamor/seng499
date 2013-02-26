package map.terrain 
{
	import hex.terrain.Terrain;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class TerrainForce 
	{
		private var direction:int;
		private var terrain:Terrain;
		public function TerrainForce(terrain:Terrain, direction:int) 
		{
			this.terrain = terrain;
			this.direction = direction;
		}	
	}
}