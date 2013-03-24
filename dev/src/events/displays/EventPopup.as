package events.displays 
{
	import common.displays.Display;
	import common.displays.Popup;
	import common.ui.NeptuneButtons;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class EventPopup extends Display 
	{
		public static const WIDTH:int	= 380,
							HEIGHT:int	= 300,
							COLOR:uint	= 0x88000000;
		
		public function EventPopup(text:String = null, addCloseButton:Boolean = false)
		{
			super(null, 0, 0, WIDTH, HEIGHT);
			clearColor = COLOR;
			blocksUpdates = true;
			if (text) addGraphic(new Text(text));
			
			if (addCloseButton) {
				
				var that:Display = this;
				add(NeptuneButtons.close(width, height, function():void {
					
					stack.popIfTop(that);
				}));
			}
		}
		
		override public function set parent(value:World):void 
		{
			super.parent = value;
			
			centerOnParent();
		}
	}

}