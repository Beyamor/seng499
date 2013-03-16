package undersea.displays {

    import flash.geom.Rectangle;
	import hex.HexTile;
    import hex.HexView;
    import map.MapView;
	import model.Game;
    import model.PlayerData;
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
    import net.flashpunk.World;
    import common.ui.Button;
    import common.Assets;
    import observatory.ComponentData;
	import observatory.ObservatoryComponent;
    import common.displays.Display;
	import observatory.Instrument;
	import net.flashpunk.utils.Input;

    public class UnderseaDisplay extends Display 
	{
		private var game:Game;
		private var tile:HexTile;
		
        public function UnderseaDisplay(parent:World, game:Game, tile:HexTile) 
		{
			this.game = game;
			this.tile = tile;
			
            super(parent, 0, 0, FP.width, FP.height);
			
			setUpButtons();
			setUpInstruments();	
        }
			
		private function clickedBack():void
		{
			FP.world = new HexView(game, game.state.getLastViewedHex().x, game.state.getLastViewedHex().y);
			
		}
		
		private function setUpButtons():void
		{
			add(Button.description()
						.fixedAt(FP.width - 58, FP.height - 42)
						.withImageAndText(new Image(Assets.IMG_MAPBUTTONBACKGROUND), new Text("back"))
						.withDepth(-1)
						.whenClicked(clickedBack)
						.build());
		}
				
		private function setUpInstruments():void
		{
			var instrument:ObservatoryComponent;
			var instruments:Vector.<ObservatoryComponent> = game.data.getHexData(tile.indices).observatoryComponents;
			
			for (var i:uint = 0; i < instruments.length; i++)
			{
				instrument = instruments[i];
				var status:String = instrument.getName();
				if (instrument is Instrument)
					status += (instrument as Instrument).isProducingData? " - Recording data" : " - Recording Noise";
				addGraphic(new Text(instrument.getName(), 20, 30 + 20 * i));
			}
		}
		
		override public function update():void
		{
			super.update();
			
			// if user clicks on the instrument in question.
			if (Input.mouseDown && Input.check("hex-scroll-up")) {
				stack.push(new InstrumentDisplay(parent));
			}
		}
		
		override public function render():void
		{
			super.render();
		}
    }
}