package model 
{
	import map.Node;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class GameState 
	{
		private var placing:Boolean = false;
		private var instrumentBeingPlaced:InstrumentData = null;
		private var connectionPoint:Node = null;
		
		public function GameState() 
		{
			
		}
		
		public function isPlacing():Boolean
		{
			return placing;
		}

		public function getInstrumentBeingPlaced():InstrumentData
		{
			return instrumentBeingPlaced;
		}
		
		public function setInstrumentBeingPlaced(newInstrument:InstrumentData):void
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
		
		public function setConnectionPoint(node:Node):void
		{
			connectionPoint = node;
		}
		
		public function getConnectionPoint():Node
		{
			return connectionPoint;
		}
	}

}
