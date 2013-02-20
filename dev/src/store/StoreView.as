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
               
			private const SCROLL_SCALING_FACTOR:Number = 12;
            private const BUTTONS_PER_PAGE:Number = 4;
			private const MAGIC_PAGE_LIMIT:Number = 2;
			
			private var pageIndex:int = 0;
			private var scrollSpeed:Number = 0;
			private var cameraTargetPoint:Point = new Point(0, 0);
			private var prePurchaseDisplay:PrePurchaseDisplay = null;
			
			private var game:Game;
		   
			public function StoreView(game:Game)
			{
					this.game = game;
				   
					addStoreButtons();
					
					prePurchaseDisplay = new PrePurchaseDisplay(game.data);
					add(prePurchaseDisplay);
			}
		   
			private function calculateScrollSpeed():void
			{
					scrollSpeed = Math.abs(cameraTargetPoint.x - FP.camera.x) / SCROLL_SCALING_FACTOR;
			}
			
			public function setTargetToPage(pageIndex:int):void
			{
				cameraTargetPoint.x = pageIndex * FP.screen.width;
				calculateScrollSpeed();
			}
		   
			private function whenClickedLeft():void
			{
					if (pageIndex > 0) 
					{
						pageIndex--;
						setTargetToPage(pageIndex);
					}
			}
		   
			private function whenClickedBack():void
			{
					FP.world = new MapView(game);
			}
		   
			private function whenClickedRight():void
			{
					if (pageIndex < MAGIC_PAGE_LIMIT) 
					{
						pageIndex++;
						setTargetToPage(pageIndex);
					}
			}
			
			private function whenClickedInstrument():void 
			{
				prePurchaseDisplay.setVisible(true);
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
											.fixedAt(0, 0)
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
				// HACK						
				var offsetIndex:Number = 0;
				var offsets:Vector.<Point> = new Vector.<Point>;
				offsets.push(new Point(0,100));
				offsets.push(new Point(0,300));
				offsets.push(new Point(400,100));
				offsets.push(new Point(400, 300));
				
				// Used to offset buttons on each 'page'
				var placerPoint:Point = new Point(0, 0);
			   
				for (var i:int = 0; i < game.data.storeList.length; i++)
				{
						// i=0 is the degenerate case
						if (i != 0 && i % BUTTONS_PER_PAGE == 0) {
								placerPoint.x = placerPoint.x + FP.screen.width;
						}
					   
						add(Button.description()
												.at(placerPoint.x + offsets[offsetIndex].x, offsets[offsetIndex].y)
												.withDepth(-1)
												.withImage(Assets.IMG_INSTRUMENT_IMAGE)
												.whenClicked(whenClickedInstrument)
												.build());
					   
						//Next button needs a new offset placement
						offsetIndex = (offsetIndex + 1) % BUTTONS_PER_PAGE;
				}
			}
		   
			override public function update():void
			{
					super.update();
				   
					FP.stepTowards(camera, cameraTargetPoint.x, cameraTargetPoint.y, scrollSpeed);
			}
		   
        }
}