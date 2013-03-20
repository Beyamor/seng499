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
					for each (force in _data.getTerrainForces(indecies))
					{
						if (!force.alreadyPropegated)
						{
							//if(iter.radius==radius)
								force.propegate(_data.getAllTerrainData(), indecies);
							/*else
								force.propegate(_state.getActiveTerrainForces(), indecies);*/
						}
					}
					//_data.getHexData(currIndecies).discover(new Terrain(Types.MUD));
					//if(data.ge)
				else
				{
					if(iter.isDone())
						break;
				}
			}
			/*
			var force:TerrainForce;
			
			if (radius <= 0)

			{
				//propegate forces to PlayerData
				for each (force in _state.getTerrainForces(indecies))
				{
					if(!force.alreadyPropegated)
						force.propegate(_data.getAllTerrainData(), indecies);
				}
			}
			else
			{
				//propegate forces to GameState
				for each (force in _state.getTerrainForces(indecies))
				{
					if(force.alreadyPropegated)	
						force.propegate(_data.getAllTerrainData(),indecies);
				}
				
				//same ugly recursion as before.
				propegateToTiles(radius - 1, indecies.north);
				propegateToTiles(radius - 1, indecies.northEast);
				propegateToTiles(radius - 1, indecies.southEast);
				propegateToTiles(radius - 1, indecies.south);
				propegateToTiles(radius - 1, indecies.southWest);
				propegateToTiles(radius - 1, indecies.northWest);
			}	
			*/	
			
		}
		
		 /**
		 * Recursively set tile data in clockwise circles
		 */
		 private function setTileData(radius:int, indices:HexIndices):void
		{
			/*if (radius == 0)
			{
				return;//SetTileData
			}
			else
			{
				//initialize a clockwise circle
				if (!_data.hexDataExists(indices.north)||!_data.getHexData(indices.north).discovered) _data.setHexData(indices.north, new HexData(new Terrain(Types.MUD), true));
				if (!_data.hexDataExists(indices.northEast)||!_data.getHexData(indices.northEast).discovered) _data.getHexData(indices.northEast).discover(new Terrain(Types.MUD));
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
			}*/
			
			var iter:HexIterator = new HexIterator(indices, radius);
			var currIndecies:HexIndices;
			while(true) 
			{
				currIndecies = iter.step();
				if (currIndecies != null)
					if (_data.getTerrainForces(currIndecies).length > 0)
					{
						for each(var terr:TerrainForce in _data.getTerrainForces(currIndecies))
							_data.getHexData(currIndecies).discover(terr.terrain);
					}
					else
						_data.getHexData(currIndecies).discover(new Terrain(Types.REEF));
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