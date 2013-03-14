package observatory 
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
		
		public function Node(d:ComponentData,x:int, y:int) 
		{
			super(d);
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
