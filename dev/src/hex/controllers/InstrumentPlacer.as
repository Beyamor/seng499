package hex.controllers {
        
    import model.HexData;
    import model.Game;
    import hex.HexTile;
    import net.flashpunk.FP;
    import hex.HexView;

    /**
     *  The InstrumentPlacer controller places an instrument on a tile.
     */
    public class InstrumentPlacer implements HexController {


        private var game:Game;
        private var instrument:InstrumentData;
        private var view:HexView;

        public function InstrumentPlacer(view:HexView, game:Game) {

            this.view       = view;
            this.game       = game;
            this.instrument = game.state.getInstrumentBeingPlaced();

        }

        public function hexSelected(tile:HexTile):void {

            game.data.addToHexInstruments(tile.xIndex, tile.yIndex, instrument);
            game.state.stopPlacingInstrument();

            // Debug to check instrument placement
            var instruments:Vector.<InstrumentData> = game.data.getHexInstruments(tile.xIndex, tile.yIndex);
            var placedInstrument:InstrumentData    = instruments[instruments.length-1] 
            FP.log("Placed " + placedInstrument.getNameString() + " at " + tile.xIndex + ", " + tile.yIndex);

            // Okay. Switch out of instrument placement I guess?
            view.controller = new TileViewer(game);

        }
    }
}
