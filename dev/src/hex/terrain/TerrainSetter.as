package hex.terrain 
{
	import flash.desktop.ClipboardFormats;
	import hex.HexIndices;
	import map.terrain.TerrainForce;
	import model.Game;
	import model.GameState;
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
		
		private var _state:GameState;
		private function get state():GameState { return _state; }
		
		public function TerrainSetter(game:Game) 
		{
			_data = game.data;
			_state = game.state;
		}
		
		/**
		 * Recursively propegate to tiles in clockwise circles
		 */

		private function propegateToTiles(radius:int,  indecies:HexIndices):void
		{	
			var iter:HexIterator = new HexIterator(indecies, radius);
			var currIndecies:HexIndices;
			var force:TerrainForce;
			while(true) 
			{
				currIndecies = iter.step();
				if (currIndecies != null)
				//should forces still be propegated to discovered terrain?
					for each (force in _data.getTerrainForces(indecies))
					{
						if (!force.alreadyPropegated)
						{
								force.propegate(_data.getAllTerrainData(), indecies);
						}
					}
				else
				{
					if(iter.isDone())
						break;
				}
			}			
		}
		
		 /**
		 * Recursively set tile data in clockwise circles
		 */
		 private function setTileData(radius:int, indices:HexIndices):void
		{
			var iter:HexIterator = new HexIterator(indices, radius);
			var currIndecies:HexIndices;
			while(true) 
			{
				currIndecies = iter.step();
				if (currIndecies != null)
				{
					if (!_data.hexDataExists(currIndecies) || !_data.hexDataDiscovered(currIndecies))
					{
						if (_data.getTerrainForces(currIndecies).length > 0)
						{
							for each(var terr:TerrainForce in _data.getTerrainForces(currIndecies))
								_data.getHexData(currIndecies).discover(terr.terrain);
						}
						else
							_data.getHexData(currIndecies).discover(new Terrain(Types.MUD));
					}
				}
				else
					break;
			}
			
		}
		
		public function setTerrain(indecies:HexIndices):void
		{
			setTileData(GameConstants.EXPO_RADIUS, indecies);
		}
		
		public function setTerrainForces(indecies:HexIndices):void
		{
			propegateToTiles(GameConstants.EXPO_RADIUS, indecies);
		}
		
	}

}