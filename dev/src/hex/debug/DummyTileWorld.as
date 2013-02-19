package hex.debug 
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.World;
	import hex.HexTile;

	import model.HexData;
	import net.flashpunk.graphics.Text;
	import model.Game;
	//import ObservatoryComponent;
	
	/**
	 * This is just a dummy world for me to test transitioning from a hex tile.
	 * @author beyamor
	 */
	public class DummyTileWorld extends World 
	{
		private var color:uint;
		
		public function DummyTileWorld(tile:HexTile, game:Game)
		{
			color = tile.color;

			var instrument:ObservatoryComponent;
			var instruments:Vector.<ObservatoryComponent> = game.data.getHexInstruments(tile.xIndex, tile.yIndex);

			for (var i:uint = 0; i < instruments.length; ++i) {
				instrument = instruments[i];
				addGraphic(new Text(instrument.getName(), 20, 30 + 20 * i));
			}
		}
		
		override public function render():void 
		{
			Draw.rect(0, 0, FP.width, FP.height, color);
			
			super.render();
		}
	}

}
