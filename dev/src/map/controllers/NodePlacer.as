package map.controllers 
{
	import common.ui.Cursor;
	import map.displays.MapDisplay;
	import map.MapView;
	import map.Node;
	import map.NodeEntity;
	import model.Game;
	/**
	 * ...
	 * @author beyamor
	 */
	public class NodePlacer implements MapController 
	{
		private var game:Game;
		private var mapView:MapView;
		
		public function NodePlacer(game:Game, mapView:MapView)
		{
			this.game		= game;
			this.mapView	= mapView;
		}
		
		public function start():void {
			
			mapView.setCursor(Cursor.forPlacingInstrument(game.state.getInstrumentBeingPlaced()));
		}
		
		public function nodeClicked(node:NodeEntity):void {
		
			// Do nothing. Nodes shouldn't be placed over nodes.
		}
		
		public function emptySpaceClicked(mapX:Number, mapY:Number):void {
			
			game.data.addNode(new Node(mapX, mapY));
			
			game.data.removeFromInventory(game.state.getInstrumentBeingPlaced());
			game.state.stopPlacingInstrument();
			
			mapView.inventoryDisplay.updateSelectors();
			
			mapView.removeCursor();
			mapView.mapDisplay.add(new NodeEntity(game.data.nodeList[game.data.nodeList.length - 1], game));
			mapView.controller = new HexViewer(mapView);
		}
	}

}