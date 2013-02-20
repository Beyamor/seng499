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
			
			var addedInstrument:Instrument = new Instrument(instrument, tile)
			game.state.getConnectionPoint().connect(addedInstrument);
            game.data.addToHexInstruments(tile.xIndex, tile.yIndex, addedInstrument);
            game.state.stopPlacingInstrument();

            // Debug to check instrument placement
            var instruments:Vector.<ObservatoryComponent> = game.data.getHexInstruments(tile.xIndex, tile.yIndex);
            var placedInstrument:ObservatoryComponent    = instruments[instruments.length-1] 
            FP.log("Placed " + placedInstrument.getName() + " at " + tile.xIndex + ", " + tile.yIndex);

            // Okay. Switch out of instrument placement I guess?
            view.controller = new TileViewer(game);

        }
    }
}
