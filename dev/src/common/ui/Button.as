package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Button extends Entity
	{
	
		private var screenX:int;
		private var screenY:int;
		private var clickFunc:Function;
		
		public function Button(x:int, y:int, clickFunc:function) 
		{
			screenX = x;
			screenY = y;
			this.x = FP.camera.x + screenX;
			this.y = FP.camera.y + screenY;
			this.clickFunc = clickFunc;
		}
		
		public function wasClicked():Boolean
		{
			if (Input.mousePressed)
			{
				if ( Input.mouseX >= x && Input.mouseX <= x + width)//uses world coordinates
				{
					if ( Input.mouseY >= y && Input.mouseY <= y + height)//uses world coordinates
					{
						return true;
					}
				}
			}
			return false;
		}
		
		private function onClick()
		{
			clickFunc();
		}
		
		public override function update()
		{
			x = FP.camera.x + screenX;
			y = FP.camera.y + screenY;
			
			if (wasClicked())
			{
				onClick();
			}
		}
		
		
	}
}