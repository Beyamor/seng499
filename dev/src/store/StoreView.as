package store
{
        import flash.geom.Point;
        import flash.geom.Rectangle;
        import hex.HexView;
        import map.MapView;
        import model.Game;
        import net.flashpunk.FP;
        import net.flashpunk.Graphic;
        import net.flashpunk.graphics.Image;
        import net.flashpunk.graphics.Text;
        import net.flashpunk.World;
        import common.ui.Button;
        import common.Assets;
        import store.ui.ButtonPaginator;
        import observatory.ComponentData;
       
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

                        private var purchaseButtonPages:ButtonPaginator;
		   
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

                        private function purchaseFunction(component:ComponentData):Function {

                            return function():void {

                                FP.log(component.getName());
                            }
                        }
		   
			public function populateStoreInventory():void
			{
                                var purchaseButtons:Vector.<Button> = new Vector.<Button>;
                                
                                // Ugh, vector's map is silllly
                                game.data.storeList.forEach(
                                    function (component:ComponentData, _:int, __:Vector.<ComponentData>):void {

                                        purchaseButtons.push(Button.description()
                                                            .withDepth(-1)
                                                            .withImageAndText(
                                                                Assets.IMG_MAPBUTTONBACKGROUND,
                                                                new Text(component.getName()))
                                                            .whenClicked(purchaseFunction(component))
                                                            .build());
                                });

                                purchaseButtons.forEach(function(button:Button, _:int, __:Vector.<Button>):void { add(button); });
                                
                                purchaseButtonPages = new ButtonPaginator(
                                                        new Rectangle(100, 100, FP.width - 200, 350),
                                                        2, 2,
                                                        purchaseButtons);
			}
		   
			override public function update():void
			{
					super.update();
				   
					FP.stepTowards(camera, cameraTargetPoint.x, cameraTargetPoint.y, scrollSpeed);
			}
		   
        }
}
