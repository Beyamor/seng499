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
		
                // Can we change this to isPlacing or something like that?
		public function isPlacing():Boolean
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

                public function stopPlacingInstrument():void {

                    instrumentBeingPlaced = null;
                    placing = false;
                }
	}

}
