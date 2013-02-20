package map 
{
    import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import model.GameState;
	import model.Game;
	import common.Assets;
    import hex.HexView;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Node extends ObservatoryComponent
	{
		private var mapX:int;
		private var mapY:int;
		private var connections:Vector.<ObservatoryComponent>;
		
		public function Node(x:int, y:int) 
		{
			mapX = x;
			mapY = y;
			connections = new Vector.<ObservatoryComponent>;
		}
		
		public function getMapX():int
		{
			return mapX;
		}
		
		public function getMapY():int
		{
			return mapY;
		}
		
		public function connect(component:ObservatoryComponent)
		{
			connections.push(component);
		}
	}

}
