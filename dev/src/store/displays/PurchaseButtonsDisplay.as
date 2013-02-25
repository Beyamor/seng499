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
    import store.PrePurchaseDisplay;

    public class PurchaseButtonsDisplay extends Display {
 
	private static const SCROLL_SCALING_FACTOR:Number   = 100;
        private static const HORIZONTAL_NUMBER:uint         = 2;
        private static const VERTICAL_NUMBER:uint           = 2;

        private var playerData:PlayerData;

	private var pageIndex:int = 0;
	private var scrollSpeed:Number = 0;
	private var cameraTargetPoint:Point = new Point(0, 0);
	
        private var purchaseButtonPages:ButtonPaginator;

        public function PurchaseButtonsDisplay(parent:World, playerData:PlayerData) {

            super(parent, 100, 100, FP.width - 200, 350);

            this.playerData = playerData;

            populateStoreInventory();
        }

	override public function update():void
        {
                super.update();
                
                FP.stepTowards(camera, cameraTargetPoint.x, cameraTargetPoint.y, scrollSpeed);
        }

        public function goToNextPage():void {

		if (pageIndex < highestPageIndex) 
		{
			pageIndex++;
			setTargetToPage(pageIndex);
		}
        }

         private function get highestPageIndex():int {

            return playerData.storeList.length / (HORIZONTAL_NUMBER * VERTICAL_NUMBER);
         }
		  
        public function goToPreviousPage():void {

		if (pageIndex > 0) 
		{
			pageIndex--;
			setTargetToPage(pageIndex);
		}
        }
	   
	private function calculateScrollSpeed():void
	{
			scrollSpeed = Math.abs(cameraTargetPoint.x - camera.x) / SCROLL_SCALING_FACTOR;
	}
	
	public function setTargetToPage(pageIndex:int):void
	{
		cameraTargetPoint.x = pageIndex * FP.screen.width;
		calculateScrollSpeed();
	}
		
        private function purchaseFunction(component:ComponentData):Function {

             return function():void {

                if (stack) stack.push(new PrePurchaseDisplay(parent, playerData, component));
             }
         }

        public function populateStoreInventory():void
        {
                var purchaseButtons:Vector.<Button> = new Vector.<Button>;
                
                // Ugh, vector's map is silllly
                playerData.storeList.forEach(
                    function (component:ComponentData, _:int, __:Vector.<ComponentData>):void {

                        purchaseButtons.push(Button.description()
                                            .withDepth(-1)
                                            .withImageAndText(
                                                Assets.IMG_MAPBUTTONBACKGROUND,
                                                new Text(component.getName()))
                                            .whenClicked(purchaseFunction(component))
                                            .build());
                });

                for each (var button:Button in purchaseButtons) add(button);
                
                purchaseButtonPages = new ButtonPaginator(
                                        new Rectangle(x, y, width, height),
                                        HORIZONTAL_NUMBER, VERTICAL_NUMBER,
                                        purchaseButtons);
        }
    }
}
