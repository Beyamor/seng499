package hex.terrain 
{
	import hex.HexIndices;
	import model.PlayerData;
	import hex.terrain.Types;
	import hex.HexData;
	/**
	 * Terrain setter exists to seperate terrain setting from playerData.  
	 * When given an index, it spirals outward adding terrain as it goes to its full radius.
	 * @author Lambwatt
	 */
	public class TerrainSetter 
	{
		private var _data:PlayerData;
		private function get data():PlayerData { return _data; }
		
		public function TerrainSetter(data:PlayerData) 
		{
			_data = data;
		}
		
		/**
		 * Recursively propegate to tiles in clockwise circles
		 */
		public function propegateToTiles(radius:int, storeForces:Boolean, indecies:HexIndices)
		{
			/*if (radius == 0)
			{
				if (storeForces);
				//propegate forces to PlayerData
				else;
				//propegate forces to GameState
			}
			else
				propegateToTiles(radius - 1, storeForces);*/
		}
		
		 /**
		 * Recursively set tile data in clockwise circles
		 */
		 public function setTileData(radius:int, indices:HexIndices):void
		{
			/*if(!_data.getHexData(indecies).discovered)
				_data.getHexData(indecies).discover(new Terrain(Types.MUD));*/
			if (radius == 0)
			{
				return;//SetTileData
			}
			else
			{
				//initialize a clockwise circle
				if (!_data.hexDataExists(indices.north)||!_data.getHexData(indices.north).discovered) _data.setHexData(indices.north, new HexData(new Terrain(Types.MUD), true));
				if (!data.hexDataExists(indices.northEast)||!_data.getHexData(indices.northEast).discovered) _data.getHexData(indices.northEast).discover(new Terrain(Types.MUD));
				if (!_data.hexDataExists(indices.southEast)||!_data.getHexData(indices.southEast).discovered) _data.getHexData(indices.southEast).discover(new Terrain(Types.MUD));
				if (!_data.hexDataExists(indices.south)||!_data.getHexData(indices.south).discovered) _data.getHexData(indices.south).discover(new Terrain(Types.MUD));
				if (!_data.hexDataExists(indices.southWest)||!_data.getHexData(indices.southWest).discovered) _data.getHexData(indices.southWest).discover(new Terrain(Types.MUD));
				if (!_data.hexDataExists(indices.northWest)||!_data.getHexData(indices.southEast).discovered) _data.getHexData(indices.northWest).discover(new Terrain(Types.MUD));
					
				//man this is ugly. I thought recursions were supposed to be beutiful.
				//I think I'll clean this up later
				setTileData(radius - 1, indices.north);
				setTileData(radius - 1, indices.northEast);
				setTileData(radius - 1, indices.southEast);
				setTileData(radius - 1, indices.south);
				setTileData(radius - 1, indices.southWest);
				setTileData(radius - 1, indices.northWest);
			}
		}

		/*for (var r:int = 0; r < GameConstants.EXPO_RADIUS; r++ )
		{
			propegateToTiles(r, r == GameConstants.EXPO_RADIUS - 1);		
			setTileData(r);
		}*/
		
		public function setTerrain(indecies:HexIndices):void
		{
			setTileData(GameConstants.EXPO_RADIUS, indecies);
		}
		
	}

}