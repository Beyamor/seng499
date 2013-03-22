package data 
{
	import model.GameTables;
	import model.PlayerData;
	import observatory.ComponentData;
	import observatory.Instrument;
	import observatory.ObservatoryComponent;
	import observatory.properties.InstrumentProperties;
	import hex.HexData;
	/**
	 * This guy sums the data currently being produced.
	 * @author beyamor
	 */
	public class DataTally 
	{
		private var playerData:PlayerData;
		
		public function DataTally(playerData:PlayerData)
		{
			this.playerData = playerData;
		}
		
		public function get activeInstrumentCount():uint {
			
			var count:uint = 0;
			
			for each (var instrument:Instrument in playerData.instruments) {
				
				if (instrument.isProducingData)
				{
					if (instrument.interestingEventIsOccurring) count += 2 * instrument.getDataValue();
					else count += instrument.getDataValue()
				}
			}
			
			return count;
		}
		
		public function get baseSum():uint {
			
			return activeInstrumentCount;
		}
		
		public function get bonusSum():uint {
			
			var count:uint = 0;
			
			for each (var instrument:Instrument in playerData.instruments) {
				
				if (instrument.interestingEventIsOccurring)
					++count;
			}
			
			return count;
		}
	}

}