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
	import common.Assets;
        import hex.controllers.HexController;
        import hex.controllers.ControllerFactory;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexView extends World 
	{
		private var grid:HexGrid;
		private var scrollCamera:ScrollCamera;
		private var returningToMap:Boolean = false;
		private var game:Game;
                public var  controller:HexController;
		
		public function HexView(game:Game) 
		{			
			this.game = game;

                        // Temporary. Creating an instrument to place.
                        // TODO: Ask MP why we're using instrument stubs and not instruments here
                        game.state.setInstrumentBeingPlaced(new InstrumentData(randomInstrumentName(), null));

                        controller = (new ControllerFactory).createFor(game, this);

                        // the hex grid bounds are 100% arbitrary, so deal with it
                        scrollCamera = new ScrollCamera(350, 0, 0, 2000, 2000);
			grid = new HexGrid(this, 64, 2000, 2000);

                        add(Button.description()
                                    .at(FP.width - 50, 30)
                                    .withDepth(-1)
                                    .withImage(new Image(Assets.IMG_MAP_FROM_HEX_BUTTON))
                                    .whenClicked(function():void {

                                        returningToMap = true;
                                    })
                                    .build());
		}

                /**
                 *      Yoinked from: http://actionscriptsnips.blogspot.ca/2009/08/generate-random-string.html
                 *      Temporary until reading real instruments.
                 */
                private function randomInstrumentName():String{

                    var strlen:uint = 8;
                    var chars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
                    var num_chars:Number = chars.length - 1;
                    var randomChar:String = "";

                    for (var i:Number = 0; i < strlen; i++){

                        randomChar += chars.charAt(Math.floor(Math.random() * num_chars));
                    }

                    return randomChar;
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
										
                                        controller.hexSelected(tile);
                                    }
                                }
                            }
                        }
		}
	}

}
