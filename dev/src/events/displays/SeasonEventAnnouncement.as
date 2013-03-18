package events.displays 
{
	import common.displays.Display;
	import events.world.SeasonalEvent;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class SeasonEventAnnouncement extends Display 
	{
		public function SeasonEventAnnouncement(event:SeasonalEvent)
		{
			super(null, 0, 0, 400, 300);
			
			clearColor		= Math.round( Math.random() * 0xFFFFFF ) | 0xFF000000;
			blocksUpdates	= true;
			
			addGraphic(new Text(event.season.name + " - " + event.moneyAward));
		}
		
		override public function set parent(value:World):void 
		{
			super.parent = value;
			
			centerOnParent();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.mousePressed && stack) stack.popIfTop(this);
		}
	}

}