package model 
{
	import flash.geom.Point;
	import observatory.Connectable;
    import observatory.ComponentData;
	//import GameConstants;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class GameState 
	{
		private var placing:int = GameConstants.NOT_PLACING;
		private var instrumentBeingPlaced:ComponentData = null;
		private var connectionPoint:Connectable = null;
		private var lastViewedHexX:int = 0;
		private var lastViewedHexY:int = 0;
		
		public function GameState() 
		{
			
		}
		
		public function isPlacing():Boolean
		{
			return placing != GameConstants.NOT_PLACING;
		}
		
		public function isSelectingNode():Boolean
		{
			return placing == GameConstants.SELECTING_NODE_ON_MAP;
		}

		public function getInstrumentBeingPlaced():ComponentData
		{
			return instrumentBeingPlaced;
		}
		
		public function setInstrumentBeingPlaced(newInstrument:ComponentData):void
		{
			instrumentBeingPlaced = newInstrument;
			placing = GameConstants.SELECTING_NODE_ON_MAP;
		}

		public function stopPlacingInstrument():void 
		{
			instrumentBeingPlaced = null;
			connectionPoint = null;
			placing = GameConstants.NOT_PLACING;
        }
		
		public function setConnectionPoint(con:Connectable):void
		{
			connectionPoint = con;
			placing = GameConstants.PLACING_ON_HEX;
		}
		
		public function getConnectionPoint():Connectable
		{
			return connectionPoint;
		}
		
		public function selectNode():Boolean
		{
			return placing = GameConstants.SELECTING_CONNECTION_ON_HEX;
		}
		
		public function isConnecting():Boolean
		{
			return placing == GameConstants.SELECTING_CONNECTION_ON_HEX;
		}
		
		public function isSelectingHex():Boolean
		{
			return placing == GameConstants.PLACING_ON_HEX;
		}
		
		public function getLastViewedHex():Point
		{
			return new Point(lastViewedHexX, lastViewedHexY);
		}
		
		public function setLastViewedHex(x:int,y:int):void
		{
				lastViewedHexX = x;
				lastViewedHexY = y;
		}
	}

}
