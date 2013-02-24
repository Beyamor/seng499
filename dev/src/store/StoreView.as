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
                        private var purchaseButtons:PurchaseButtonsDisplay;
                        private var navButtons:NavButtonsDisplay;
                        private var background:BackgroundDisplay;

			public function StoreView(game:Game)
			{
					this.game = game;

                                        purchaseButtons = new PurchaseButtonsDisplay(this, game.data);
                                        navButtons      = new NavButtonsDisplay(this, game, purchaseButtons);
                                        background      = new BackgroundDisplay(this, Assets.IMG_BG);
			}
	   
                        override public function update():void {

                            background.update();
                            purchaseButtons.update();
                            navButtons.update();
                            background.updateLists();
                            purchaseButtons.updateLists();
                            navButtons.updateLists();
                            super.update();
                        }

                        override public function render():void {

                            background.render();
                            super.render();
                            purchaseButtons.render();
                            navButtons.render();
                        }
        }
}
