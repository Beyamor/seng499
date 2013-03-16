package undersea 
{
	import common.displays.BackgroundDisplay;
	import common.displays.DisplayStack;
	import common.displays.InstructionDisplay;
	import common.NeptuneWorld;
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
		private var tile:HexTile;
		
		public function UnderseaView(tile:HexTile, game:Game) 
		{
			this.game = game;
			this.tile = tile;
			
			var backgroundDisplay:BackgroundDisplay = new BackgroundDisplay(this, Assets.IMG_UNDERSEA_BG);
			var underseaDisplay:UnderseaDisplay = new UnderseaDisplay(this, game, tile);
			
			displays = new DisplayStack(
				backgroundDisplay,
				underseaDisplay);
		}
		
	}

}
