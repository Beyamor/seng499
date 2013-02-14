package hex 
{
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import flash.geom.Rectangle;
	import common.ui.Button;
	import net.flashpunk.graphics.Image;
	import map.MapView;
	import hex.debug.DummyTileWorld;
	import common.Assets;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexView extends World 
	{

		/*[Embed(source="/assets/map_from_hex_button.png")]
		private const MAP_BUTTON_SOURCE:Class; Refactored be MP*/

		private var grid:HexGrid;
		private var scrollCamera:ScrollCamera;
		private var returningToMap:Boolean = false;
		private var game:Game;
		
		public function HexView(game:Game) 
		{			
			this.game = game;
                        // the hex grid bounds are 100% arbitrary, so deal with it
                        scrollCamera = new ScrollCamera(350, 0, 0, 2000, 2000);
			grid = new HexGrid(this, 64, 2000, 2000);

                        add(Button.description()
                                    .at(FP.width - 50, 30)
                                    .withDepth(-1)
                                    .withImage(new Image(Assets.IMG_MAP_FROM_HEX_BUTTON))//Refactored by MP
                                    .whenClicked(function():void {

                                        returningToMap = true;
                                    })
                                    .build());
		}
		
		override public function update():void 
		{
			super.update();

                        scrollCamera.update();
			grid.fillView();

                        // This is kinda junk.
                        if (returningToMap) {

                            FP.world = new MapView(game);
                        }

                        else {
                        
                            if (Input.mousePressed) {
								
                                for each (var tile:HexTile in grid.tilesOnScreen) {

                                    if (tile.containsPoint(FP.world.mouseX, FP.world.mouseY)) {
										
                                        FP.world = new DummyTileWorld(tile);
                                        break;
                                    }
                                }
                            }
                        }
		}
	}

}
