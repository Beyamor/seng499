package events.displays 
{
	import common.displays.Display;
	import common.PositionHelper;
	import common.ui.Button;
	import common.ui.NeptuneButtons;
	import events.world.SeasonalEvent;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class SeasonEventAnnouncement extends EventPopup 
	{
		public function SeasonEventAnnouncement(event:SeasonalEvent)
		{
			super();
			
			if (event.moneyAward > 0)
			{
				var instructionText:Text = new Text("Complete by " + event.season.name + " to earn $" + event.moneyAward + ".");
				PositionHelper.centerXOn(instructionText, this);
				instructionText.y = height - 65;
				addGraphic(instructionText);
			}
			
			var that:SeasonEventAnnouncement = this;
			var closeButton:Button = NeptuneButtons.standard("close", 0, height - 35, function():void { stack.popIfTop(that); } );
			PositionHelper.centerXOn(closeButton, this);
			add(closeButton);
			
			var descriptionText:Text = new Text(event.description, 10, 10);
			addGraphic(descriptionText);
		}
	}

}