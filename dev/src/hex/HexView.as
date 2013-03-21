package hex 
{
	import common.displays.ControlPanel;
	import common.displays.Display;
	import common.displays.InstructionDisplay;
	import common.NeptuneWorld;
	import common.displays.DataDisplay;
    import flash.geom.Point;
	import hex.displays.HexControlPanel;
	import hex.displays.HexDisplay;
	import hex.ui.ConnectionCable;
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import flash.geom.Rectangle;
	import common.ui.Button;
	import net.flashpunk.graphics.Image;
	import map.MapView;
	import common.Assets;
	import hex.controllers.HexController;
	import hex.controllers.ControllerFactory;
	import hex.math.SpaceConverter;
	import undersea.UnderseaView;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexView extends NeptuneWorld 
	{
		public var controller:HexController;
		private var controlPanel:ControlPanel;
		private var game:Game;
		public var hexDisplay:HexDisplay;
		public var instructionDisplay:InstructionDisplay;
		
		public function HexView(game:Game, mapX:Number, mapY:Number)
		{
			super();
			game.state.setLastViewedHex(mapX, mapY);
			this.game	= game;
			controller	= (new ControllerFactory).createFor(game, this);
			
			controlPanel	= new HexControlPanel(this, game).thatSlidesOn;
			hexDisplay		= new HexDisplay(this, game, mapX, mapY);
			hexDisplay.expandRightEdgeTo(controlPanel);
			
			instructionDisplay = new InstructionDisplay(this);
			
			displays.push(
				hexDisplay,
				controlPanel,
				new DataDisplay(this, game.data),
				instructionDisplay
			);
			
			if (game.state.isConnecting()) instructionDisplay.show("select a node or junction box");
		}
		
		public function returnToMapView():void {
			
			controlPanel.slideOff(function():void {
				
				FP.world = new MapView(game);
			});
		}
		
		public function goToUnderseaView(tile:HexTile):void {
			
			controlPanel.slideOff(function():void {
				
				FP.world = new UnderseaView(tile, game);
			});
		}
	}

}
