package events.instruments 
{
	import common.Collections;
	import data.DataSample;
	import hex.HexData;
	import model.Game;
	import observatory.Instrument;
	import observatory.ObservatoryComponent;
	import model.GameTables;
	
	/**
	 * This dude, uh, gives instruments events?
	 * @author beyamor
	 */
	public class InstrumentEventDispatcher 
	{
		
		public function InstrumentEventDispatcher()
		{
			
		}
		
		/**
		 * Returns the instrument/hex object on which the event was started or null if no event was started
		 */
		public function maybeDispatchInstrumentEvent(game:Game):Object {
			
			if (Math.random() > GameConstants.INSTRUMENT_EVENT_PROBABILITY) return null;
			
			// Using a dynamic hex/instrument object because I'm too lazy to create an actual HexInstrumentPair class
			var instrumentHexPairs:Vector.<Object> = new Vector.<Object>;
			
			for each (var hexData:HexData in game.data.hexes) {
				
				for each (var instrument:Instrument in hexData.instruments) {
					
					instrumentHexPairs.push( {
						
						"hex": hexData,
						"instrument": instrument
					});
				}
			}
			
			if (instrumentHexPairs.length == 0) return null;
			
			var instrumentHexPair:Object = Collections.any(instrumentHexPairs);
			instrumentHexPair.instrument.startInterestingEvent();
			return instrumentHexPair;
		}
	}
}