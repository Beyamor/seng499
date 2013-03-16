package store.displays {

    import net.flashpunk.FP;
    import net.flashpunk.World;
    import model.Game;
    import map.MapView;
    import common.Assets;
    import common.ui.Button;
    import common.displays.Display;

    public class NavButtonsDisplay extends Display {

        private var game:Game;
        private var purchaseButtons:PurchaseButtonsDisplay;

        public function NavButtonsDisplay(parent:World, game:Game, purchaseButtons:PurchaseButtonsDisplay) {

            super(parent, 0, 0, FP.width, FP.height);

            this.game               = game;
            this.purchaseButtons    = purchaseButtons;

            addButtons();
        }


	private function addButtons():void
	{
			add(Button.description()
									.fixedAt(0, FP.height - 100)
									.withDepth(-1)
									.withImage(Assets.IMG_LEFT)
									.whenClicked(function():void {
                                                                            purchaseButtons.goToPreviousPage();
                                                                        })
									.build());     
								   
								   
			add(Button.description()
									.fixedAt(300, FP.height - 100)
									.withDepth(-1)
									.withImage(Assets.IMG_BACK)
									.whenClicked(function():void {
                                                                            FP.world = new MapView(game);
                                                                        })
									.build());                     
								   
			add(Button.description()
									.fixedAt(600, FP.height - 100)
									.withDepth(-1)
									.withImage(Assets.IMG_RIGHT)
									.whenClicked(function():void {
                                                                            purchaseButtons.goToNextPage();
                                                                        })
									.build());     
	}
    }
}
