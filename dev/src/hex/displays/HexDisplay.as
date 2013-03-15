package hex.displays 
{
	import common.displays.Display;
	import common.displays.DataDisplay;
	import hex.Cartographer;
	import hex.controllers.HexSubhitbox;
	import hex.HexFactory;
	import hex.HexGrid;
	import hex.HexTile;
	import hex.HexView;
    import flash.geom.Point;
	import common.ScrollCamera;
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
	import observatory.Connectable;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexDisplay extends Display 
	{
		private var grid:HexGrid;
		private var scrollCamera:ScrollCamera;
		private var returningToMap:Boolean = false;
		private var game:Game;
		private var view:HexView;
		
		public function HexDisplay(hexParent:HexView, game:Game, mapX:Number, mapY:Number)
		{
			super(hexParent, 0, 0, FP.width, FP.height);
			
			view					= hexParent;
			const WIDTH:uint        = GameConstants.HEX_VIEW_WIDTH;
			const HEIGHT:uint       = GameConstants.HEX_VIEW_HEIGHT;
			const HEX_RADIUS:uint   = GameConstants.HEX_RADIUS;

			var converter:SpaceConverter = SpaceConverter.getCanonical();

			var hexCoords:Point         = converter.getConvertedPoint(mapX, mapY);
			var initialCameraX:Number    = hexCoords.x - width/2;
			var initialCameraY:Number    = hexCoords.y - height/2;

			camera.x = initialCameraX;
			camera.y = initialCameraY;

			scrollCamera = new ScrollCamera(this, 350, 0, 0, WIDTH, HEIGHT);

            var factory:HexFactory = new HexFactory(new Cartographer(game.data), game.data);
			grid = new HexGrid(factory, this, camera, HEX_RADIUS, WIDTH, HEIGHT);
		
			this.game = game;
		}
		
		override public function update():void 
		{
			super.update();
			
			scrollCamera.update();
			grid.fillView();
			
			if (Input.mousePressed && isFirstDisplayContaingMouse) {
					
				for each (var tile:HexTile in grid.tilesOnScreen) {

					if (tile.containsPoint(mouseX, mouseY)) {
						
						if (game.state.isConnecting())
						{
							for each (var sub:HexSubhitbox in tile.subHitboxes)
							{
								if (sub.component is Connectable)
								{
									if (sub.containsPoint(mouseX, mouseY))
									view.controller.connectInstrument(sub.component as Connectable);
								}
							}
						}
						else
						{
							view.controller.hexSelected(tile);
						}
					}
				}
			}		
			
		}
	}

}