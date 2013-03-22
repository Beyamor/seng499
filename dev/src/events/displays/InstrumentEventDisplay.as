package events.displays 
{
	import common.displays.Popup;
	import common.PositionHelper;
	import common.ui.Button;
	import common.ui.NeptuneButtons;
	import hex.HexData;
	import model.Game;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import observatory.Instrument;
	import undersea.UnderseaView;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class InstrumentEventDisplay extends Popup 
	{
		private var instrument:Instrument;
		private var hexData:HexData;
		
		public function InstrumentEventDisplay(game:Game, hexData:HexData, instrument:Instrument)
		{
			this.instrument	= instrument;
			this.hexData	= hexData;
			
			super(null, 380, 300);
			
			// TODO: Figure out what we're doing with colours.
			clearColor		= 0x88FFFFFF;
			blocksUpdates	= true;
			
			var eventText:Text = new Text(eventMessage);
			PositionHelper.centerOn(eventText, this);
			addGraphic(eventText);
			
			var viewButton:Button = NeptuneButtons.standard("Check it out", 0, 0, function():void {
				
				FP.world = UnderseaView.createForInstrument(game, hexData, instrument);
			});
			PositionHelper.centerXOn(viewButton, this);
			viewButton.y = height - viewButton.height - 10;
			add(viewButton);
		}
		
		private function get eventMessage():String {
			
			return "Your " + instrument.getName() + " is recording\n"
					+"an interesting event!";
		}
	}

}