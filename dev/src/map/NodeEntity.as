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
	import observatory.Node;
	import common.Assets;
    import hex.HexView;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class NodeEntity extends Entity
	{
		private var node:Node;
		//private var connections:Vector.<Instrument>;
		
		public function NodeEntity(node:Node) 
		{
			graphic = new Image(Assets.IMG_NODE);
			height = (graphic as Image).height;
			width = (graphic as Image).width;
			
			//mapX/Y correspond to the center of the node rather than the upper right corner.
			this.node = node;
			super(node.getMapX() - (width / 2), node.getMapY() - (height / 2));
			
		}
		
		public override function update():void
		{
			super.update();
			if (checkForMouseClick())
			{
				if ((FP.world as MapView).getGame().state.isPlacing())
				{
					//(FP.world as MapView).getGame().state.setConnectionPoint(node);//This will be more fleshed out when JBs are an alternative to nodes.
					(FP.world as MapView).getGame().state.selectNode();
					//FP.console.log("placing");
				}else if ((FP.world as MapView).getGame().state.isConnecting())
				{
					(FP.world as MapView).getGame().state.setConnectionPoint(node);
				}
				else
				{
					//FP.console.log("zooming");
				}
				goToNodeHex();
			}
		}
		
		private function checkForMouseClick():Boolean
		{
			if (Input.mousePressed)
			{
				if ( FP.world.mouseX >= x && FP.world.mouseX <= x + width)
				{
					if ( FP.world.mouseY >= y && FP.world.mouseY <= y + height)
					{
						return true;
					}
				}
			}
			return false;
		}
		
		private function goToNodeHex():void
		{
			if (!(world is MapView)) {

				FP.log("Error - node's world is not a MapView");
				return;
			}

			var game:Game = (world as MapView).getGame();

			FP.world = new HexView(game, node.getMapX(), node.getMapY());
		}
	}

}
