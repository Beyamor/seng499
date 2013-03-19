package map 
{
	import common.Assets;
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author beyamor
	 */
	public class NodePlacementValidator 
	{
		private static const PLACEMENT_MASK:BitmapData	= FP.getBitmap(Assets.IMG_NODE_PLACEMENT_MASK);
		private static const VALID_PLACEMENT_COLOR:uint	= 0xFFFFFF;
		
		public function NodePlacementValidator() 
		{
			
		}
		
		public function isValidPlacement(mapX:int, mapY:int):Boolean {
			
			return PLACEMENT_MASK.getPixel(mapX, mapY) == VALID_PLACEMENT_COLOR;
		}
	}

}