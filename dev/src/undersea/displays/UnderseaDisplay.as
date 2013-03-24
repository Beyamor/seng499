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
					
			setUpComponents();	
        }
			
		
		private function clickedInstrument(component:ObservatoryComponent):Function
		{
			return function():void {
				
				underseaView.showInstrumentDisplay(component);
             }
		}
		
		private function setUpComponents():void
		{
			var components:Vector.<ObservatoryComponent> = hexData.observatoryComponents;
			
			for each (var component:ObservatoryComponent in components) 
			{
				
				// evenly spaced out on ground
				var placePoint:Point = new Point((FP.width / (components.length + 1)) * (components.indexOf(component) + 1), 400);
				var placeImage:Image = new Image(component.getImage());
				placeImage.scale = 3.0;
				var placeText:Text = new Text(component.getName());
				placeText.color = 0x000000;
				// HACK: Centering the 00 makes it look much better, but breaks the button - CP
				//placeImage.centerOO();
				placeText.centerOO();
				placeText.x += (placeImage.scaledWidth / 2);
				placeText.y += (placeImage.scaledHeight / 2); // remove these later - CP
				
				
				
				add(Button.description()
					.fixedAt(placePoint.x, placePoint.y)
					.withImageAndText(
						placeImage,
						placeText)
					.withDepth(-1)
					.whenClicked(clickedInstrument(component))
					.build());
			}
		
		}
    }
}