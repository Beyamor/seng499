package model 
{
	import Connectable;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class GameState 
	{
		private var placing:Boolean = false;
		private var instrumentBeingPlaced:ComponentData = null;
		private var connectionPoint:Connectable = null;
		
		public function GameState() 
		{
			
		}
		
		public function isPlacing():Boolean
		{
			return placing;
		}

		public function getInstrumentBeingPlaced():ComponentData
		{
			return instrumentBeingPlaced;
		}
		
		public function setInstrumentBeingPlaced(newInstrument:ComponentData):void
		{
			instrumentBeingPlaced = newInstrument;
			placing = true;
		}

		public function stopPlacingInstrument():void 
		{
			instrumentBeingPlaced = null;
			connectionPoint = null;
			placing = false;
        }
		
		public function setConnectionPoint(node:Connectable):void
		{
			connectionPoint = node;
		}
		
		public function getConnectionPoint():Connectable
		{
			return connectionPoint;
		}
	}

}
