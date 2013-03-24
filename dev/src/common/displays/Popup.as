package common.displays 
{
	import common.Assets;
	import common.ui.Button;
	import common.ui.NeptuneButtons;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author beyamor
	 */
	public class Popup extends Display 
	{
		
		public function Popup(parent:World, width:uint, height:uint)
		{
			clearColor = 0xEE000000;
			
			// Just going to assume the popup should be centered
			super(
				parent,
				0, 0, // Sucks, but parent height and width not set until after super call
				width,
				height);
			
			x = parentHalfWidth - width / 2;
			y = parentHalfHeight - height / 2;
				
			add(NeptuneButtons.close(width, height, function():void { close(); } ));
		}
		
		public function close():void {
			
			// Just gunna assume this is the top of the stack
			if (stack) stack.popIfTop(this);
		}
	}

}