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
	import hex.entities.HexInstrumentImage;

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
			if (tile.data.instruments.length < 2)
			{
				var addedInstrument:ObservatoryComponent = new Instrument(instrument, tile);
				game.state.getConnectionPoint().connect(addedInstrument);
				game.data.getHexData(tile.indices).addObservatoryComponent(addedInstrument);
				game.data.removeFromInventory(game.state.getInstrumentBeingPlaced());
				
				tile.changed = true;
				
				game.state.stopPlacingInstrument();
				
				view.removeCursor();
				view.hexDisplay.removeConnectionCable();
				
				
				
				/*if (instrument.isSeenInHexGrid())
				{
					if (tile.data.instruments.length == 0)	
						view.hexDisplay.add(new HexInstrumentImage(addedInstrument,
															tile.x - instrument.getImage().width - 5,
															tile.y - instrument.getImage().height - 5));
					else									
						view.hexDisplay.add(new HexInstrumentImage(addedInstrument as ObservatoryComponent, 5, 5));
				}*/
				// Okay. Switch out of instrument placement I guess?
				view.controller = new TileViewer(view, game);
			}
		}
    }
}
