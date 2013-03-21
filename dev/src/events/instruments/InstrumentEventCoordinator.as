package events.instruments 
{
	import common.displays.Popup;
	import events.displays.InstrumentEventDisplay;
	import hex.HexData;
	import model.Game;
	import observatory.Instrument;
	/**
	 * ...
	 * @author beyamor
	 */
	public class InstrumentEventCoordinator 
	{
		
		public function InstrumentEventCoordinator() 
		{
			
		}
		
		public function coordinateEvents(game:Game):void {
			
			for each (var instrument:Instrument in game.data.instruments) instrument.endInterestingEvent();
			var eventDispatcher:InstrumentEventDispatcher = new InstrumentEventDispatcher;
			
			var hexInstrumentPair:Object	= eventDispatcher.maybeDispatchInstrumentEvent(game);
			var eventOccurred:Boolean		= (hexInstrumentPair != null);
			
			if (eventOccurred) {
				
				var hexData:HexData					= hexInstrumentPair.hex;
				var instrumentWithEvent:Instrument	= hexInstrumentPair.instrument;
				
				game.state.pushEventDisplay(new InstrumentEventDisplay(game, hexData, instrumentWithEvent));
			}
		}
	}

}