package hex.controllers {
        
    import model.HexData;
    import hex.HexTile;
    import net.flashpunk.FP;

    /**
     *  The InstrumentPlacer controller places an instrument on a tile.
     */
    public class InstrumentPlacer implements HexController {

        public function hexSelected(tile:HexTile):void {

           FP.log("adding instrument at " + tile.xIndex + ", " + tile.yIndex);
        }
    }
}
