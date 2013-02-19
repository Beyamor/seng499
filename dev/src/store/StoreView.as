package store
{
        import flash.geom.Point;
        import hex.HexView;
        import map.MapView;
        import model.Game;
        import net.flashpunk.FP;
        import net.flashpunk.Graphic;
        import net.flashpunk.graphics.Image;
        import net.flashpunk.World;
        import common.ui.Button;
        import common.Assets;
       
        /**
         * ...
         * TODO: Where does it pull my author name from? Coolton is cheeky, though.
         * @author coolton
         */
         
        public class StoreView extends World { 
               
                private var SCROLL_SCALING_FACTOR:Number = 12;
                private var NUMBER_OF_BUTTONS:Number = 4
				
                private var scrollSpeed:Number = 0;
                private var targetPoint:Point = new Point(0, 0);
                private var offsetIndex:Number = 0;
                private var offsets:Vector.<Point> = new Vector.<Point>;
				private var game:Game;
               
                public function StoreView(game:Game)
                {
                        this.game = game;
                       
						// HACK
                        offsets.push(new Point(0,0));
                        offsets.push(new Point(0,400));
                        offsets.push(new Point(400,0));
                        offsets.push(new Point(400, 400));
						
                        addStoreButtons();
                }
               
                private function calculateScrollSpeed():void
                {
                        scrollSpeed = Math.abs(targetPoint.x - FP.camera.x) / SCROLL_SCALING_FACTOR;
                }
               
                private function whenClickedLeft():void
                {
                        if (targetPoint.x > 0) {
							targetPoint.x = targetPoint.x - FP.screen.width;
							calculateScrollSpeed();
						}
                }
               
                private function whenClickedBack():void
                {
                        FP.world = new MapView(game);
                }
               
                private function whenClickedRight():void
                {
						// TODO: if at end of list
                        targetPoint.x = targetPoint.x + FP.screen.width;
                        calculateScrollSpeed();
                }
               
                private function addStoreButtons():void
                {
                        add(Button.description()
                                                .fixedAt(0, FP.height - 100)
                                                .withDepth(-1)
                                                .withImage(Assets.IMG_LEFT)
                                                .whenClicked(whenClickedLeft)
                                                .build());     
                                               
                                               
                        add(Button.description()
                                                .fixedAt(200, FP.height - 100)
                                                .withDepth(-1)
                                                .withImage(Assets.IMG_BACK)
                                                .whenClicked(whenClickedBack)
                                                .build());                     
                                               
                        add(Button.description()
                                                .fixedAt(600, FP.height - 100)
                                                .withDepth(-1)
                                                .withImage(Assets.IMG_RIGHT)
                                                .whenClicked(whenClickedRight)
                                                .build());     
                       
                        populateStoreInventory();
                       
                }
               
                public function populateStoreInventory():void
                {
						// Used to offset buttons on each 'page'
                        var placerPoint:Point = new Point(0, 0);
                       
                        for (var i:int = 0; i < game.data.storeList.length; i++)
                        {
                                if (i != 0 && i % NUMBER_OF_BUTTONS == 0) {
                                        placerPoint.x = placerPoint.x + FP.screen.width;
                                }
                               
                                add(Button.description()
                                                        .at(placerPoint.x + offsets[offsetIndex].x, offsets[offsetIndex].y)
                                                        .withDepth(-1)
                                                        .withImage(Assets.IMG_INSTRUMENT_IMAGE)
                                                        .whenClicked(function():void {
                                                                FP.console.log("clicked instrument");
                                                        })
                                                        .build());
                               
								//Next button needs a new offset placement
                                offsetIndex = (offsetIndex + 1) % NUMBER_OF_BUTTONS;
                        }
                }
               
                override public function update():void
                {
                        super.update();
                       
                        FP.stepTowards(camera, targetPoint.x, targetPoint.y, scrollSpeed);
                }
               
        }
}