package hex.controllers {
        
    import model.Game;
    import hex.HexTile;
    import net.flashpunk.FP;
    import hex.HexView;
    import observatory.ObservatoryComponent;
    import observatory.Instrument;
    import observatory.ComponentData;

    /**
     *  The InstrumentPlacer controller places an instrument on a tile.
     */
    public class InstrumentPlacer implements HexController {


        private var game:Game;
        private var instrument:ComponentData;
        private var view:HexView;

        public function InstrumentPlacer(view:HexView, game:Game) {

            this.view       = view;
            this.game       = game;
            this.instrument = game.state.getInstrumentBeingPlaced();

        }

        public function hexSelected(tile:HexTile):void {
			
			var addedInstrument:Instrument = new Instrument(instrument, tile)
			game.state.getConnectionPoint().connect(addedInstrument);
            game.data.getHexData(tile.indices).addObservatoryComponent(addedInstrument);
            game.state.stopPlacingInstrument();

            // Debug to check instrument placement
            var instruments:Vector.<ObservatoryComponent> = game.data.getHexData(tile.indices).observatoryComponents;
            var placedInstrument:ObservatoryComponent    = instruments[instruments.length-1] 
            FP.log("Placed " + placedInstrument.getName() + " at " + tile.indices.x + ", " + tile.indices.y);

            // Okay. Switch out of instrument placement I guess?
            view.controller = new TileViewer(game);

        }
    }
}
