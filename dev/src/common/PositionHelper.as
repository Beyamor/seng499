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
			
			thingToBeCentered.x = centerReference.width / 2 - thingToBeCentered.width / 2;
		}
		
		public static function centerYOn(thingToBeCentered:*, centerReference:*):void {
			
			thingToBeCentered.y = centerReference.height / 2 - thingToBeCentered.height / 2;
		}
	}

}