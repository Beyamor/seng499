package map.controllers 
{
	import map.MapView;
	import map.NodeEntity;
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexViewer implements MapController 
	{
		private var mapView:MapView;
		
		public function HexViewer(mapView:MapView)
		{
			this.mapView = mapView;
		}
		
		public function start():void {
			
			// Nothing to do
		}
		
		public function nodeClicked(node:NodeEntity):void {
			
			mapView.goToHexViewFromNode(node);
		}
		
		public function emptySpaceClicked(mapX:Number, mapY:Number):void {
			
			// Can't visit empty space
		}
	}

}