package events.displays 
{
	import common.displays.Display;
	import common.ui.NeptuneButtons;
	import hex.HexData;
	import model.Game;
	import observatory.Instrument;
	/**
	 * ...
	 * @author beyamor
	 */
	public class EventResultPopup extends EventPopup 
	{
		
		/*public function EventResultPopup(text:String, button:Boolean, game:Game, hexData:HexData, instrument:Instrument)
		{
			super(text, true);
			
			var viewButton:Button = NeptuneButtons.standard("Check it out", 0, 0, function():void {
				
				FP.world = UnderseaView.createForInstrument(game, hexData, instrument);
			});
			
			PositionHelper.centerXOn(viewButton, this);
			viewButton.y = height - viewButton.height - 10;
			add(viewButton);
		}*/
		
		public function EventResultPopup(text:String)
		{
			super(text, true);
		}
	}

}