package store.displays 
{
	import common.displays.Display;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import observatory.ComponentData;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class InsufficientFundsDisplay extends Display 
	{
		
		public function InsufficientFundsDisplay(parent:World, componentData:ComponentData)
		{
			var text:Text = new Text("Can't afford " + componentData.getName());
			
			var width:Number	= text.width + 40;
			var height:Number	= text.height + 40;
			
			super(parent, FP.halfWidth - width / 2, FP.halfHeight - height / 2, width, height);
			
			text.centerOO();
			addGraphic(text, 0, halfWidth, halfHeight);
			
			clearColor = 0xFF000000;
			blocksUpdates = true;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.mousePressed && !containsMouse) stack.pop();
		}
	}

}