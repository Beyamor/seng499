package map.terrain 
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public interface LocationStructure 
	{
		
		public function distanceToPoint(point:Point):Number;
		public function angleFromPoint(point:Point):Number;
		
	}

}