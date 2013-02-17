package map 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import model.GameState;
	import model.Game;
	import common.Assets;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Node extends Entity
	{
		public function Node(x:int, y:int) 
		{
			super(x, y);
			graphic = new Image(Assets.IMG_NODE);
			height = (graphic as Image).height;
			width = (graphic as Image).width;
		}
		
		public override function update():void
		{
			super.update();
			if (checkForMouseClick())
			{
				//goToNodeHex();
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
						if ((FP.world as MapView).getGame().state.getPlacing())
						{
							FP.console.log("placing");
						}else 
						{
							FP.console.log("zooming");
						}
						return true;
					}
				}
			}
			return false;
		}
		
		private function goToNodeHex():void
		{
			
		}
	}

}
