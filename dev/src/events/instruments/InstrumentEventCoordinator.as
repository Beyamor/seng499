package events.instruments 
{
	import common.displays.Popup;
	import events.displays.InstrumentEventDisplay;
	import hex.HexData;
	import model.Game;
	import observatory.Instrument;
	/**
	 * This guy used to be responsible for ending interesting events as well as triggering the event dispatcher.
	 * Its responsibilities have diminished somewhat. However, pushing the instrument event display gives it enough to do, kinda.
	 * If more instrument event-y stuff needs to happen, beyond just starting an event, make it go here.
	 * Otherwise, I dunno, consider scrapping this guy.
	 * @author beyamor
	 */
	public class InstrumentEventCoordinator 
	{		
		public function coordinateEvents(game:Game):void {
			
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