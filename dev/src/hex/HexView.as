package hex 
{
	import common.NeptuneWorld;
    import flash.geom.Point;
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

			add(Button.description()
						.fixedAt(FP.width - 50, 30)
						.withDepth(-1)
						.withImage(new Image(Assets.IMG_MAP_FROM_HEX_BUTTON))
						.whenClicked(function():void {

							FP.world = new MapView(game);
						})
						.build());
						
			displays.push(new HexDisplay(this, game, mapX, mapY));
		}
	}

}
