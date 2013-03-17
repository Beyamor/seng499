package hex.controllers {
        
	import common.ui.Cursor;
    import model.Game;
    import hex.HexTile;
    import net.flashpunk.FP;
    import hex.HexView;
	import observatory.Connectable;
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

			view.setCursor(Cursor.forPlacingInstrument(instrument));
        }

        public function hexSelected(mouseX:Number, mouseY:Number, tile:HexTile):void {
			
			var addedInstrument:ObservatoryComponent = new Instrument(instrument, tile)
			game.state.getConnectionPoint().connect(addedInstrument);
            game.data.getHexData(tile.indices).addObservatoryComponent(addedInstrument);
			game.data.removeFromInventory(game.state.getInstrumentBeingPlaced());
            game.state.stopPlacingInstrument();
			
			view.removeCursor();
			view.hexDisplay.removeConnectionCable();

            // Okay. Switch out of instrument placement I guess?
			view.controller = new TileViewer(view, game);
		}
    }
}
