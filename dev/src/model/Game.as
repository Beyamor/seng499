package model 
{
	import hex.terrain.Terrain;
	import hex.terrain.Types;
	import map.terrain.Feature;
	import map.terrain.LocationPoint;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Game 
	{
		public var state:GameState = new GameState();
		public var data:PlayerData = new PlayerData();
		public function Game() 
		{
			state = new GameState();
			data = new PlayerData();
			//addFeatures();
		}
		
		//Aww fuck it, just move this to playerData asap.
		public function addFeature(feature:Feature)
		{
			data.terrainFeatures.push(feature);
		}
		
		public function getFeatures()
		{
			return data.terrainFeatures;
		}
	}
}