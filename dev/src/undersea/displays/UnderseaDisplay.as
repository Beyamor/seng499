package undersea.displays {

	import common.ui.NeptuneButtons;
	import flash.geom.Point;
    import flash.geom.Rectangle;
	import hex.HexData;
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
	import undersea.UnderseaView;

    public class UnderseaDisplay extends Display 
	{
		private var game:Game;
		private var hexData:HexData;
		private var underseaView:UnderseaView
		
        public function UnderseaDisplay(view:UnderseaView, game:Game, hexData:HexData) 
		{
			this.underseaView	= view;
			this.game			= game;
			this.hexData		= hexData;
			
            super(parent, 0, 0, FP.width, FP.height);
			
			add(NeptuneButtons.standard(
				"back", 
				width - 58, 
				height - 42, 
				function():void {
					FP.world = new HexView(game, game.state.getLastViewedHex().x, game.state.getLastViewedHex().y);
				}));
					
			setUpInstruments();	
        }
			
		
		private function clickedInstrument(instrument:Instrument):Function
		{
			return function():void {
				
				underseaView.showInstrumentDisplay(instrument);
             }
		}
		
		private function setUpInstruments():void
		{
			var instruments:Vector.<Instrument> = hexData.instruments;
			
			for each (var instrument:Instrument in instruments) 
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
    }
}