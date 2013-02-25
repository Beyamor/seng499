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
        import common.displays.DisplayStack;
        import store.displays.*;
       
        /**
         * ...
         * TODO: Where does it pull my author name from? Coolton is cheeky, though.
         * @author coolton
         */
         
        public class StoreView extends World { 

              		private var game:Game;
                        private var displays:DisplayStack;

			public function StoreView(game:Game)
			{
					this.game = game;

                                        var purchaseButtons:PurchaseButtonsDisplay  = new PurchaseButtonsDisplay(this, game.data);
                                        var navButtons:NavButtonsDisplay            = new NavButtonsDisplay(this, game, purchaseButtons);
                                        var background:BackgroundDisplay            = new BackgroundDisplay(this, Assets.IMG_BG);

                                        displays = new DisplayStack(
                                            background,
                                            purchaseButtons,
                                            navButtons);
			}
	   
                        override public function update():void {

                            displays.update();
                            super.update();
                        }

                        override public function render():void {

                            displays.render();
                            super.render();
                        }
        }
}
