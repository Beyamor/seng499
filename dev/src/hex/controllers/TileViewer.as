package hex.controllers {

    import hex.debug.DummyTileWorld;
    import hex.HexTile;
    import net.flashpunk.FP;
    import model.Game;

    /**
     *      The TileViewer controller transitions the game to viewing a single tile.
     */
    public class TileViewer implements HexController {

        private var game:Game;

        public function TileViewer(game:Game) {

            this.game = game;
        }

        public function hexSelected(tile:HexTile):void {

            FP.world = new DummyTileWorld(tile, game);
        }
    }
}
