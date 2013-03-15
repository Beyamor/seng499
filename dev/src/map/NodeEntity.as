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
	import observatory.Node;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class NodeEntity extends Entity
	{
		private var node:Node;
		private var game:Game
		//private var connections:Vector.<Instrument>;
		
		public function NodeEntity(node:Node, game:Game) 
		{
			graphic = new Image(Assets.IMG_NODE);
			height = (graphic as Image).height;
			width = (graphic as Image).width;
			
			//mapX/Y correspond to the center of the node rather than the upper right corner.
			this.node = node;
			super(node.getMapX() - (width / 2), node.getMapY() - (height / 2));
			this.game = game;
		}
		
		public function checkForMouseClick():Boolean
		{
			if (Input.mousePressed)
			{
				if ( world.mouseX >= x && world.mouseX <= x + width)
				{
					if ( world.mouseY >= y && world.mouseY <= y + height)
					{
						return true;
					}
				}
			}
			return false;
		}
		
		public function get mapX():int { return node.getMapX(); }
		public function get mapY():int { return node.getMapY(); }
		public function get data():Node { return node; }
	}

}
