package model 
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class GameState 
	{
		private var placing:Boolean = false;
		private var instrumentBeingPlaced:InstrumentStub = null;
		
		public function GameState() 
		{
			
		}
		
		public function getPlacing():Boolean
		{
			return placing;
		}
		
		public function getInstrumentBeingPlaced():InstrumentStub
		{
			return instrumentBeingPlaced;
		}
		
		public function setInstrumentBeingPlaced(newInstrument:InstrumentStub):void
		{
			instrumentBeingPlaced = newInstrument;
			placing = true;
		}
	}

}
