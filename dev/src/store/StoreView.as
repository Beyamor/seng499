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
        import net.flashpunk.graphics.TiledImage;
        import net.flashpunk.graphics.Text;
        import net.flashpunk.World;
        import common.ui.Button;
        import common.Assets;
        import store.ui.ButtonPaginator;
        import observatory.ComponentData;
        import common.displays.BackgroundDisplay;
        import store.displays.*;
       
        /**
         * ...
         * TODO: Where does it pull my author name from? Coolton is cheeky, though.
         * @author coolton
         */
         
        public class StoreView extends World { 

              		private var game:Game;
                        private var purchaseButtonsDisplay:PurchaseButtonsDisplay;
                        private var background:BackgroundDisplay;

			public function StoreView(game:Game)
			{
					this.game = game;

                                        purchaseButtonsDisplay = new PurchaseButtonsDisplay(this, game.data);
				   
					addStoreButtons();

                                        // Background
                                        background = new BackgroundDisplay(this, Assets.IMG_BG);
			}
	   
			private function whenClickedLeft():void
			{
                            purchaseButtonsDisplay.goToPreviousPage();
			}
		   
			private function whenClickedBack():void
			{
					FP.world = new MapView(game);
			}
		   
			private function whenClickedRight():void
			{
                            purchaseButtonsDisplay.goToNextPage();
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
			}

                        override public function update():void {

                            background.update();
                            purchaseButtonsDisplay.update();
                            background.updateLists();
                            purchaseButtonsDisplay.updateLists();
                            super.update();
                        }

                        override public function render():void {

                            background.render();
                            super.render();
                            purchaseButtonsDisplay.render();
                        }
        }
}
