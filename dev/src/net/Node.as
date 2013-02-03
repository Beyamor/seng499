package net 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
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
			height = 32;
			width = 32;
		}
		
		public override function update()
		{
			super();
			
			if (Input.mousePressed())
			{
				if ( Input.mouseX >= x && Input.mouseX =< x + width)
				{
					if ( Input.mouseY >= y && Input.mouseY =< y + height)
					{
						go_to_node_hex();
					}
				}
			}
		}
		
		private function go_to_node_hex():void
		{
			
		}
	}

}