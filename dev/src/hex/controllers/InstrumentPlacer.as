package hex.controllers {
        
	import common.ui.Cursor;
	import hex.entities.ConnectedCable;
	import hex.terrain.Types;
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
		
		private function stopConnecting():void {
			
			view.hexDisplay.removeConnectionCable();
			game.state.unsetConnectionPoint();
			view.removeCursor();
			
			view.controller = new ConnectionStarter(view, game);
		}
		
		private function placeInstrument(tile:HexTile):void {
			
			var addedInstrument:Instrument = new Instrument(instrument, tile);
			tile.addInstrument(addedInstrument);
			
			addNewCable(tile);
			
			game.state.getConnectionPoint().connect(addedInstrument);
			game.data.removeFromInventory(game.state.getInstrumentBeingPlaced());				
			game.state.stopPlacingInstrument();
			++game.data.instrumentsPlaceThisSeason;
			
			view.removeCursor();
			view.hexDisplay.removeConnectionCable();
			
			// Okay. Switch out of instrument placement I guess?
			view.controller = new TileViewer(view, game);
		}

        public function hexSelected(mouseX:Number, mouseY:Number, tile:HexTile):void {
			
			// Okay. Uh. CP suggested that clicking on the connection point again would unset it
			var wasConnectionStartPoint:Boolean = false;
			for each (var component:ObservatoryComponent in tile.data.observatoryComponents) {
				
				if (component == game.state.getConnectionPoint()) {
					
					wasConnectionStartPoint = true;
					break;
				}
			}
			
			if (wasConnectionStartPoint) {
				
				stopConnecting();
			}
			
			// Check tile population
			else if (tile.data.observatoryComponents.length >= 2 || tile.data.hasNode()) {
				
				view.instructionDisplay.show("tile is full, place on another");
			}
			
			// Check tile discovery
			else if (!tile.data.discovered) {
				
				view.instructionDisplay.show("place on a discovered tile");
			}
			
			// Okay. Actually place the dang thing
			else {
				
				placeInstrument(tile);
			}
		}
		
		public function addNewCable(tile:HexTile):void
		{
			//uses fact that entity will have been added to the back of the list
			var insX:int = tile.hexSubEntities[tile.data.instruments.length - 1].wireX();
			var insY:int = tile.hexSubEntities[tile.data.instruments.length - 1].wireY();
			
			view.hexDisplay.add(new ConnectedCable(game.state.connectionX, game.state.connectionY, insX, insY));
		}
    }
}
