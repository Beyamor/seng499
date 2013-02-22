package undersea 
{
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
        import observatory.ObservatoryComponent;
	/**
	 * ...
	 * @author Colton Phillips
	 */
	public class UnderseaView extends World
	{
		// TODO: Undersea view is connected to the HexView
		// TODO: Populate View with instrument list
		// TODO: An undersea view has an InstrumentDisplay
		
		private var game:Game;
		private var color:uint;
		private var tile:HexTile;
		
		public function UnderseaView(tile:HexTile, game:Game) 
		{
			this.game = game;
			this.color = tile.color;
			this.tile = tile;
		}
		
		private function clickedBack():void
		{
			FP.world = new HexView(game, 0, 0);
		}
		
		override public function begin():void
		{
			super.begin();

			var instrument:ObservatoryComponent;
			var instruments:Vector.<ObservatoryComponent> = game.data.getHexData(tile.indices).observatoryComponents;
			
			for (var i:uint = 0; i < instruments.length; i++)
			{
				instrument = instruments[i];
				addGraphic(new Text(instrument.getName(), 20, 30 + 20 * i));
			}
			
			add(Button.description()
						.fixedAt(FP.width - 58, FP.height - 42)
						.withImageAndText(new Image(Assets.IMG_MAPBUTTONBACKGROUND), new Text("back"))
						.withDepth(-1)
						.whenClicked(clickedBack)
						.build());
		}
		
		override public function render():void
		{
			Draw.rect(0, 0, FP.width, FP.height, color);
			super.render();
		}
		
	}

}
