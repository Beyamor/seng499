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
		
		public override function update():void
		{
			super.update();
			if (checkForMouseClick())
			{
				if (game.state.isPlacing())
				{
					game.state.setConnectionPoint(node);//This will be more fleshed out when JBs are an alternative to nodes.
					FP.console.log("placing");
				}else 
				{
					FP.console.log("zooming");
				}
				goToNodeHex();
			}
		}
		
		private function checkForMouseClick():Boolean
		{
			if (Input.mousePressed)
			{
				if ( world.mouseX >= x && world.mouseX <= x + width)
				{
					if ( world.mouseY >= y && world.mouseY <= y + height)
					{
						FP.log("clicked a bitch");
						return true;
					}
				}
			}
			return false;
		}
		
		private function goToNodeHex():void
		{
			FP.world = new HexView(game, node.getMapX(), node.getMapY());
		}
	}

}
