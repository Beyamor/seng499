package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Button extends Entity
	{
		
		public function Button(x:int, y:int) 
		{
			
		}
		
		public function was_clicked():Boolean
		{
			if (Input.mousePressed)
			{
				if ( Input.mouseX >= x && Input.mouseX <= x + width)
				{
					if ( Input.mouseY >= y && Input.mouseY <= y + height)
					{
						return true;
					}
				}
			}
			return false;
		}
		
	}

}