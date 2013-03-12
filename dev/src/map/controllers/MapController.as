package map.controllers 
{
	import map.NodeEntity;
	
	/**
	 * The map controller describes how user actions in the map view should be handled.
	 * @author beyamor
	 */
	public interface MapController 
	{
		function start():void;
		function nodeClicked(node:NodeEntity):void;
		function emptySpaceClicked(mapX:Number, mapY:Number):void;
	}
	
}