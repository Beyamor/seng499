package undersea 
{
	import common.displays.BackgroundDisplay;
	import common.displays.DisplayStack;
	import common.displays.InstructionDisplay;
	import common.NeptuneWorld;
	import hex.HexData;
	import hex.HexTile;
	import hex.HexView;
	import model.Game;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.World;
	import common.ui.Button;
	import net.flashpunk.FP;
	import common.Assets;
	import observatory.ComponentData;
	import observatory.Instrument;
    import observatory.ObservatoryComponent;
	import undersea.displays.InstrumentDisplay;
	import undersea.displays.UnderseaDisplay;
	
	/**
	 * ...
	 * @author Colton Phillips
	 */
	public class UnderseaView extends NeptuneWorld
	{
		private var game:Game;
		
		public function UnderseaView(hexData:HexData, game:Game) 
		{
			this.game = game;
			
			var backgroundDisplay:BackgroundDisplay = new BackgroundDisplay(this, Assets.IMG_UNDERSEA_BG);
			var underseaDisplay:UnderseaDisplay = new UnderseaDisplay(this, game, hexData);
			
			displays = new DisplayStack(
				backgroundDisplay,
				underseaDisplay);
		}
		
		public function showInstrumentDisplay(instrument:Instrument):void {
			
			// TODO: Should this be verifying that instrument is an Instrument? Yikes. Your move, CP.
			displays.push(new InstrumentDisplay(this, instrument));
		}
		
		public static function createForInstrument(game:Game, hexData:HexData, instrument:Instrument):UnderseaView {
			
			var view:UnderseaView = new UnderseaView(hexData, game);
			view.showInstrumentDisplay(instrument);
			return view;
		}
	}

}
