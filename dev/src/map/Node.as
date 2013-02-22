package map 
{
        import observatory.Connectable;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Node extends Connectable
	{
		private var mapX:int;
		private var mapY:int;
		
		public function Node(x:int, y:int) 
		{
			mapX = x;
			mapY = y;		
		}
		
		public function getMapX():int
		{
			return mapX;
		}
		
		public function getMapY():int
		{
			return mapY;
		}
		
		public override function getName():String
		{
			return "Node";
		}
	}

}
