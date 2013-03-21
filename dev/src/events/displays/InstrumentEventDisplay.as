package events.displays 
{
	import common.displays.Popup;
	import common.PositionHelper;
	import hex.HexData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import observatory.Instrument;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class InstrumentEventDisplay extends Popup 
	{
		private var instrument:Instrument;
		private var hexData:HexData;
		
		public function InstrumentEventDisplay(hexData:HexData, instrument:Instrument)
		{
			this.instrument	= instrument;
			this.hexData	= hexData;
			
			super(null, 450, 300);
			
			// TODO: Figure out what we're doing with colours.
			clearColor		= 0x88FFFFFF;
			blocksUpdates	= true;
			
			var eventText:Text = new Text(eventMessage);
			PositionHelper.centerOn(eventText, this);
			addGraphic(eventText);
		}
		
		private function get eventMessage():String {
			
			return "Your " + instrument.getName() + " is recording an interesting event!";
		}
	}

}