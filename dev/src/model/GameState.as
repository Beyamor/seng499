package model 
{
	import common.Assets;
	import common.displays.Display;
	import events.displays.SeasonEventAnnouncement;
	import events.world.SeasonalEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import hex.HexIndices;
	import map.terrain.TerrainForce;
	import observatory.Connectable;
    import observatory.ComponentData;
	import time.Season;
	import time.Seasons;
	import flash.media.SoundMixer;
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
		private var _activeTerrainForces:Object = new Object;
		private var eventDisplayQueue:Vector.<Display> = new <Display>[];
		
		public var connectionX:int;
		public var connectionY:int;
		
		public var bgSound:Sound;
		public var bgChannel:SoundChannel;
		
		
		
		public function GameState() 
		{
			// Spring
			bgChannel = new SoundChannel();
			bgSound = (new Assets.SOUND_NEPTUNE) as Sound;
			bgChannel = bgSound.play();
		}
		
		public function playSeasonalMusic(season:Season):void
		{
			trace(season.name);
			var asset:Class;
			if (season.name == Seasons.SPRING.name) 
			{
				asset = Assets.SOUND_NEPTUNE;
			}
			else if (season.name == Seasons.SUMMER.name)
			{
				asset = Assets.SOUND_AUTUMN;
			}
			else if (season.name == Seasons.FALL.name) 
			{
				asset = Assets.SOUND_SUMMER;
			}
			else if (season.name == Seasons.WINTER.name) 
			{
				asset = Assets.SOUND_NATIVE_RAINFALL;
			}
			
			bgChannel.stop();
			bgChannel.soundTransform.volume = 0;
			bgSound = (new asset) as Sound;
			
			flash.media.SoundMixer.stopAll();
			bgChannel = null;
			bgChannel = bgSound.play();
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
		
		public function unsetConnectionPoint():void {
			
			connectionPoint = null;
			state = SELECTING_CONNECTION_ON_HEX;
		}
		
		public function getConnectionPoint():Connectable
		{
			return connectionPoint;
		}
		
		public function selectNode():void
		{
			state = SELECTING_CONNECTION_ON_HEX;
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
		public function addTerrainForce(force:TerrainForce, indecies:HexIndices):void
		{
			if (!_activeTerrainForces[indecies.x])
			{
				_activeTerrainForces[indecies.x] = new Object;
				//_activeTerrainForces[indecies.x][indecies.y].push(force);
			}
			if (!_activeTerrainForces[indecies.x][indecies.y])
			{
				_activeTerrainForces[indecies.x][indecies.y] = new Vector.<TerrainForce>;
			}
			_activeTerrainForces[indecies.x][indecies.y].push(force);
		}
		
		/*public function getTerrainForces(indecies:HexIndices):Vector.<TerrainForce>
		{
			if (!_activeTerrainForces[indecies.x]) _activeTerrainForces[indecies.x] = new Vector.<TerrainForce>; 
			if (!_activeTerrainForces[indecies.x][indecies.y])	_activeTerrainForces[indecies.x][indecies.y] = new Vector.<TerrainForce>;
			return _activeTerrainForces[indecies.x][indecies.y];
		}*/
		
		public function getActiveTerrainForces():Object//Vector.< Vector.< Vector.<TerrainForce>>>
		{
			return _activeTerrainForces;
		}
		
		public function pushEventDisplay(display:Display):void {
			
			if (!display) return;
			eventDisplayQueue.push(display);
		}
		
		public function get hasEventDisplays():Boolean {
			
			return (eventDisplayQueue.length > 0)
		}
		
		public function popEventDisplay():Display {
			
			if (!hasEventDisplays) return null;
			
			return eventDisplayQueue.shift();
		}
	}

}
