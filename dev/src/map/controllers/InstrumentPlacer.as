package map.controllers 
{
	import common.ui.Cursor;
	import map.MapView;
	import map.NodeEntity;
	import model.Game;
	/**
	 * ...
	 * @author beyamor
	 */
	public class InstrumentPlacer implements MapController 
	{
		private var mapView:MapView;
		private var game:Game;
		
		public function InstrumentPlacer(game:Game, mapView:MapView)
		{
			this.mapView	= mapView;
			this.game		= game;
		}
		
		public function start():void {
			
			mapView.setCursor(Cursor.forPlacingInstrument(game.state.getInstrumentBeingPlaced()));
		}
		
		public function nodeClicked(node:NodeEntity):void {
		
			game.state.setConnectionPoint(node.data);
			mapView.goToHexViewFromNode(node);
		}
		
		public function emptySpaceClicked(mapX:Number, mapY:Number):void {
			
			// Don't try to place on empty space
		}
	}

}