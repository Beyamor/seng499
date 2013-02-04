package map 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Node extends Entity
	{
		
		[Embed(source = '../assets/Node.png')] private const NODE:Class;
		
		public function Node(x:int, y:int) 
		{
			super(x, y);
			graphic = new Image(NODE);
			height = (graphic as Image).height;
			width = (graphic as Image).width;
		}
		
		public override function update():void
		{
			super.update();
			if (check_for_mouse_click())
			{
				//go_to_node_hex();
				
			}
		}
		
		private function check_for_mouse_click():Boolean
		{
			if (Input.mousePressed)
			{
				if ( FP.world.mouseX >= x && FP.world.mouseX <= x + width)
				{
					if ( FP.world.mouseY >= y && FP.world.mouseY <= y + height)
					{
						trace("click detected on node");
						return true;
					}
				}
			}
			return false;
		}
		
		private function go_to_node_hex():void
		{
			
		}
	}

}