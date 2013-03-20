package store.displays {

	import common.displays.DisplayStack;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import hex.HexView;
    import map.MapView;
    import model.PlayerData;
	import model.GameTables;
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.World;
    import common.ui.Button;
    import common.Assets;
    import common.ui.ButtonPaginator;
    import observatory.ComponentData;
    import common.displays.Display;
	import store.StoreView;
	import store.ui.PurchaseComponentButton;

    public class PurchaseButtonsDisplay extends Display {
 
        private static const HORIZONTAL_NUMBER:uint         = 2;
        private static const VERTICAL_NUMBER:uint           = 2;
		private static const MAGIC_BOX_VALUE:uint			= 50;

        private var playerData:PlayerData;
        private var pages:ButtonPaginator;
		private var storeView:StoreView;

        public function PurchaseButtonsDisplay(parent:StoreView, playerData:PlayerData) {

            super(parent, 100, 100, FP.width - 200, 350);

            this.playerData = playerData;
			this.storeView	= parent;

            populateStoreInventory();

            clearColor = 0xff000000;
        }

		override public function update():void
        {
                super.update();
                pages.update();
        }

        public function goToPreviousPage():void { pages.goToPreviousPage(); }
        public function goToNextPage():void { pages.goToNextPage(); }
         
        public function populateStoreInventory():void
        {
                var purchaseButtons:Vector.<Button> = new Vector.<Button>;
                
                for each (var component:ComponentData in playerData.storeList) {
									
					purchaseButtons.push(new PurchaseComponentButton(
						playerData,
						storeView,
						component));					
                };

                for each (var button:Button in purchaseButtons) add(button);
                
					pages = new ButtonPaginator(
                                        this,
                                        new Rectangle(2*MAGIC_BOX_VALUE, MAGIC_BOX_VALUE, width- 4*MAGIC_BOX_VALUE, height- 2*MAGIC_BOX_VALUE),
                                        HORIZONTAL_NUMBER, VERTICAL_NUMBER,
                                        purchaseButtons);
        }
    }
}
