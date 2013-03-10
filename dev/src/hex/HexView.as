package hex 
{
	import common.displays.Display;
	import common.NeptuneWorld;
	import common.ui.DataDisplay;
    import flash.geom.Point;
	import hex.displays.HexControlPanel;
	import hex.displays.HexDisplay;
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
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexView extends NeptuneWorld 
	{
		public var  controller:HexController;
		
		public function HexView(game:Game, mapX:Number, mapY:Number)
		{
			super();

			controller = (new ControllerFactory).createFor(game, this);
			
			var hexControlPanel:Display	= new HexControlPanel(this, game).thatSlidesOn;
			var hexDisplay:Display		= new HexDisplay(this, game, mapX, mapY).withRightEdgeExpandingTo(hexControlPanel);
			
			displays.push(
				hexDisplay,
				hexControlPanel,
				new DataDisplay(this, game.data)
			);
		}
	}

}
