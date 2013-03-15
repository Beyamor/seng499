package map.controllers 
{
	import map.MapView;
	import model.Game;
	import model.GameState;
	/**
	 * This dude does its best to wrap up the logic for setting up the right map controller.
	 * @author beyamor
	 */
	public class ControllerFactory 
	{
		private var mapView:MapView;
		private function get game():Game { return mapView.getGame(); }
		private function get state():GameState { return game.state; }
		
		public function ControllerFactory(mapView:MapView) {
			
			this.mapView = mapView;
		}
		
		public function build():MapController {
			
			if (state.isPlacing()) {
				
				if (state.getInstrumentBeingPlaced().isNode())	return new NodePlacer(game, mapView);
				else											return new InstrumentPlacer(game, mapView);
			}
			
			else {
				
				return new HexViewer(mapView);
			}
		}
	}

}