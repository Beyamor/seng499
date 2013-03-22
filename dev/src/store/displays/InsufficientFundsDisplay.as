package store.displays 
{
	import common.displays.Display;
	import common.displays.Popup;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import observatory.ComponentData;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class InsufficientFundsDisplay extends Popup 
	{
		
		public function InsufficientFundsDisplay(parent:World, componentData:ComponentData)
		{
			var text:Text = new Text("Can't afford " + componentData.getName());
			
			var width:Number	= text.width + 100;
			var height:Number	= text.height + 100;
			
			super(parent, width, height);
			
			text.centerOO();
			addGraphic(text, 0, halfWidth, halfHeight);
			
			clearColor		= 0x88000000;
			blocksUpdates = true;
		}
	}

}