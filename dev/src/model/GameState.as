package model 
{
	import flash.geom.Point;
	import hex.HexIndices;
	import map.terrain.TerrainForce;
	import observatory.Connectable;
    import observatory.ComponentData;
	//import GameConstants;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class GameState 
	{
		public static const NOT_PLACING:int					= 0;
		public static const SELECTING_NODE_ON_MAP:int		= 1;
		public static const SELECTING_CONNECTION_ON_HEX:int	= 2;
		public static const PLACING_ON_HEX:int				= 3;
		
		private var state:int = NOT_PLACING;
		private var instrumentBeingPlaced:ComponentData = null;
		private var connectionPoint:Connectable = null;
		private var lastViewedHex:Point = null;
		private var _activeTerrainForces:Vector.< Vector.< Vector.<TerrainForce> > > = new Vector.< Vector.< Vector.<TerrainForce> > >;	
		
		public function GameState() 
		{
			
		}
		
		public function isPlacing():Boolean
		{
			return state != NOT_PLACING;
		}
		
		public function isSelectingNode():Boolean
		{
			return state == SELECTING_NODE_ON_MAP;
		}

		public function getInstrumentBeingPlaced():ComponentData
		{
			return instrumentBeingPlaced;
		}
		
		public function setInstrumentBeingPlaced(newInstrument:ComponentData):void
		{
			instrumentBeingPlaced = newInstrument;
			state = SELECTING_NODE_ON_MAP;
		}

		public function stopPlacingInstrument():void 
		{
			instrumentBeingPlaced = null;
			connectionPoint = null;
			state = NOT_PLACING;
        }
		
		public function setConnectionPoint(con:Connectable):void
		{
			connectionPoint = con;
			state = PLACING_ON_HEX;
		}
		
		public function getConnectionPoint():Connectable
		{
			return connectionPoint;
		}
		
		public function selectNode():Boolean
		{
			return state = SELECTING_CONNECTION_ON_HEX;
		}
		
		public function isConnecting():Boolean
		{
			return state == SELECTING_CONNECTION_ON_HEX;
		}
		
		public function isSelectingHex():Boolean
		{
			return state == PLACING_ON_HEX;
		}
		
		public function getLastViewedHex():Point
		{
			return lastViewedHex;
		}
		
		public function setLastViewedHex(x:int,y:int):void
		{
				lastViewedHex = new Point(x,y);
		}
		
		/**
		 * Used to apply terrain forces to tiles when discovering the grid.
		 * @param	force
		 * @param	indecies
		 */
		public function addTerrainForce(force:TerrainForce, indecies:HexIndices)
		{
			_activeTerrainForces[indecies.x][indecies.y].push(force);
		}
		
		public function getTerrainForces(indecies:HexIndices):Vector.<TerrainForce>
		{
			return _activeTerrainForces[indecies.x][indecies.y];
		}
	}

}
