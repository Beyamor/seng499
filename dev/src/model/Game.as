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
		private var terrainFeatures:Vector.<Feature> = new Vector.<Feature>;
		public function Game() 
		{
			state = new GameState();
			data = new PlayerData();
			addFeatures();
		}
		
		public function addFeatures()
		{
			terrainFeatures.push(new Feature(new LocationPoint(0,0),200,new Terrain(Types.SAND)));
		}
		
		public function getFeatures()
		{
			return terrainFeatures;
		}
	}
}