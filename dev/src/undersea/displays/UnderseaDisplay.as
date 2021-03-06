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
				width/2 - 48, 
				height - 22, 
				function():void {
					FP.world = new HexView(game, game.state.getLastViewedHex().x, game.state.getLastViewedHex().y);
				}));
					
			setUpComponents();	
        }
			
		
		private function clickedComponent(component:ObservatoryComponent):Function
		{
			return function():void {
				if (component.isNode()) {
					underseaView.showNodeDisplay(component);
				}
				else {
					underseaView.showInstrumentDisplay(component as Instrument);
				}
             }
		}
		
		private function setUpComponents():void
		{
			var components:Vector.<ObservatoryComponent> = hexData.observatoryComponents;
			
			for each (var component:ObservatoryComponent in components) 
			{
				
				// evenly spaced out on ground
				var MAGIC:uint = 60;
				var placePoint:Point = new Point(-15 -MAGIC + (FP.width / (components.length + 1)) * (components.indexOf(component) + 1), -MAGIC +  375);
				var placeImage:Image = new Image(component.getImage());
				placeImage.scale = 8.0;
				//var placeText:Text = new Text(component.getName());
				//placeText.color = 0x000000;
				// HACK: Centering the 00 makes it look much better, but breaks the button - CP
				//splaceImage.centerOO();
				//placeText.centerOO();
				//placeText.x += (placeImage.scaledWidth / 2);
				//placeText.y += (placeImage.scaledHeight / 2); // remove these later - CP
				
				
				
				add(Button.description()
					.fixedAt(placePoint.x, placePoint.y)
					.withImage(placeImage)
					.withDepth(-1)
					.whenClicked(clickedComponent(component))
					.build());
			}
		
		}
    }
}