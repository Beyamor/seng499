package hex 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
        import flash.geom.Rectangle;
        import common.ui.Button;
        import net.flashpunk.graphics.Image;
        import map.MapView;
	import hex.debug.DummyTileWorld;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexView extends World 
	{
            [Embed(source="/assets/map-from-hex-button.png")]
            private const MAP_BUTTON_SOURCE:Class;

            private var grid:HexGrid;
            private var scrollCamera:ScrollCamera;
            private var returningToMap:Boolean = false;
		
		public function HexView() 
		{			
                        // the hex grid bounds are 100% arbitrary, so deal with it
                        scrollCamera = new ScrollCamera(350, 0, 0, 2000, 2000);
			grid = new HexGrid(this, 64, 2000, 2000);

                        add(Button.description()
                                    .at(FP.width - 50, 30)
                                    .withDepth(-1)
                                    .withImage(new Image(MAP_BUTTON_SOURCE))
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

                            FP.world = new MapView;
                        }

                        else {
                        
                            if (Input.mousePressed) {

                                // Second time I've written this tonight.
                                // It's gotta already exist in the engine, right?
                                // If it don't, let's put it somewhere.
                                var worldMouseX:Number = Input.mouseX + FP.camera.x,
                                    worldMouseY:Number = Input.mouseY + FP.camera.y;

                                for each (var tile:HexTile in grid.tilesOnScreen) {

                                    if (tile.containsPoint(worldMouseX, worldMouseY)) {

                                        FP.world = new DummyTileWorld(tile);
                                        break;
                                    }
                                }
                            }
                        }
		}
	}

}
