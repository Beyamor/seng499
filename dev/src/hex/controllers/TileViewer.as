package hex.controllers {

    import hex.debug.DummyTileWorld;
    import hex.HexTile;
    import net.flashpunk.FP;

    /**
     *      The TileViewer controller transitions the game to viewing a single tile.
     */
    public class TileViewer implements HexController {

        public function hexSelected(tile:HexTile):void {

            FP.world = new DummyTileWorld(tile);
        }
    }
}
