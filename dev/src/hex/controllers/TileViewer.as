package hex.controllers {

    import hex.HexTile;
    import net.flashpunk.FP;
    import model.Game;
	import undersea.UnderseaView;


    /**
     *      The TileViewer controller transitions the game to viewing a single tile.
     */
    public class TileViewer implements HexController {

        private var game:Game;

        public function TileViewer(game:Game) {

            this.game = game;
        }

        public function hexSelected(tile:HexTile):void {

            FP.world = new UnderseaView(tile, game);

        }
    }
}
