package hex.controllers {

    import hex.HexTile;
	import hex.HexView;
    import net.flashpunk.FP;
    import model.Game;
	import observatory.Connectable;
	import undersea.UnderseaView;


    /**
     *      The TileViewer controller transitions the game to viewing a single tile.
     */
    public class TileViewer implements HexController {

        private var game:Game;
		private var view:HexView;

        public function TileViewer(view:HexView, game:Game) {

            this.game = game;
			this.view = view;
        }

        public function hexSelected(mouseX:Number, mouseY:Number, tile:HexTile):void {
			if(tile.discovered)
				view.goToUnderseaView(tile);
        }
    }
}
