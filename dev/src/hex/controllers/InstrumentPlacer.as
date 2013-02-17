package hex.controllers {
        
    import model.HexData;
    import hex.HexTile;
    import net.flashpunk.FP;
    import hex.HexView;

    /**
     *  The InstrumentPlacer controller places an instrument on a tile.
     */
    public class InstrumentPlacer implements HexController {

        private var instrument:Instrument;
        private var view:HexView;

        public function InstrumentPlacer(view:HexView, instrument:Instrument) {

            this.view = view;
            this.instrument = instrument;
        }

        public function hexSelected(tile:HexTile):void {

            HexData.addToInstruments(tile.xIndex, tile.yIndex, instrument);

            // Debug to check instrument placement
            var instruments:Vector.<Instrument> = HexData.getInstruments(tile.xIndex, tile.yIndex);
            var placedInstrument:Instrument     = instruments[instruments.length-1] 
            FP.log("Placed " + placedInstrument.getName() + " at " + tile.xIndex + ", " + tile.yIndex);

            // Okay. Switch out of instrument placement I guess?
            view.controller = new TileViewer;
        }
    }
}
