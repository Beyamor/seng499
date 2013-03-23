package common 
{
	/**
	 * ...
	 * @author beyamor
	 */
	public class PositionHelper 
	{
		/**
		 * Expects to things with x, y, width, and height
		 * and positions thingToBeCentered in the center of centerReference
		 */
		public static function centerOn(thingToBeCentered:*, centerReference:*):void {
			
			centerXOn(thingToBeCentered, centerReference);
			centerYOn(thingToBeCentered, centerReference);
		}
		
		public static function centerXOn(thingToBeCentered:*, centerReference:*):void {
			
			var referenceXOffset:Number = (centerReference["x"] !== undefined)? centerReference.x : 0;
			var referenceWidthOffset:Number = (centerReference["width"] !== undefined)? centerReference.width / 2 : 0;
			
			thingToBeCentered.x = referenceXOffset + referenceWidthOffset - thingToBeCentered.width / 2;
		}
		
		public static function centerYOn(thingToBeCentered:*, centerReference:*):void {
			
			var referenceYOffset:Number = (centerReference["y"] !== undefined)? centerReference.y : 0;
			var referenceHeightOffset:Number = (centerReference["height"] !== undefined)? centerReference.height / 2 : 0;
			
			thingToBeCentered.y = referenceYOffset + referenceHeightOffset - thingToBeCentered.height / 2;
		}
	}

}