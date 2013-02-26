package store.displays {

    import flash.geom.Point;
    import flash.geom.Rectangle;
    import hex.HexView;
    import map.MapView;
    import model.PlayerData;
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.World;
    import common.ui.Button;
    import common.Assets;
    import store.ui.ButtonPaginator;
    import observatory.ComponentData;
    import common.displays.Display;

    public class PurchaseButtonsDisplay extends Display {
 
        private static const HORIZONTAL_NUMBER:uint         = 2;
        private static const VERTICAL_NUMBER:uint           = 2;

        private var playerData:PlayerData;
        private var pages:ButtonPaginator;

        public function PurchaseButtonsDisplay(parent:World, playerData:PlayerData) {

            super(parent, 100, 100, FP.width - 200, 350);

            this.playerData = playerData;

            populateStoreInventory();

            clearColor = 0xff333333;
        }

	override public function update():void
        {
                super.update();
                pages.update();
        }

        public function goToPreviousPage():void { pages.goToPreviousPage(); }
        public function goToNextPage():void { pages.goToNextPage(); }

        private function purchaseFunction(component:ComponentData):Function {

             return function():void {

                if (stack) stack.push(new PrePurchaseDisplay(parent, playerData, component));
             }
         }
         
        public function populateStoreInventory():void
        {
                var purchaseButtons:Vector.<Button> = new Vector.<Button>;
                
                for each (var component:ComponentData in playerData.storeList) {

                        purchaseButtons.push(Button.description()
                                            .withDepth(-1)
                                            .withImageAndText(
                                                Assets.IMG_MAPBUTTONBACKGROUND,
                                                new Text(component.getName()))
                                            .whenClicked(purchaseFunction(component))
                                            .build());
                };

                for each (var button:Button in purchaseButtons) add(button);
                
                pages = new ButtonPaginator(
                                        this,
                                        new Rectangle(0, 0, width, height),
                                        HORIZONTAL_NUMBER, VERTICAL_NUMBER,
                                        purchaseButtons);
        }
    }
}
