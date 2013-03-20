package undersea.displays {

	import common.ui.NeptuneButtons;
	import flash.geom.Point;
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
			
			setUpNavigationButtons();
			setUpInstruments();	
        }
			
		private function clickedBack():void
		{
			FP.world = new HexView(game, game.state.getLastViewedHex().x, game.state.getLastViewedHex().y);
			
		}
		
		private function setUpNavigationButtons():void
		{
			add(NeptuneButtons.standard("back", width - 58, height - 42, clickedBack));
		}
		
		private function clickedInstrument(instrument:ObservatoryComponent):Function
		{
			return function():void {
				stack.push(new InstrumentDisplay(parent, instrument));
			
             }
		}
		
		private function setUpInstruments():void
		{
			var instruments:Vector.<ObservatoryComponent> = game.data.getHexData(tile.indices).observatoryComponents;
			
			for each (var instrument:ObservatoryComponent in instruments) 
			{
				// evenly spaced out on ground
				var placePoint:Point = new Point((FP.width / (instruments.length + 1)) * (instruments.indexOf(instrument) + 1), 400);
				var placeImage:Image = new Image(instrument.getImage());
				placeImage.scale = 3.0;
				add(Button.description()
					.fixedAt(placePoint.x, placePoint.y)
					.withImageAndText(
						placeImage,
						new Text(instrument.getName()))
					.withDepth(-1)
					.whenClicked(clickedInstrument(instrument))
					.build());
			}
		
		}
		
		override public function update():void
		{
			super.update();
		}
		
		override public function render():void
		{
			super.render();
		}
    }
}