package events.world 
{
	import common.displays.Display;
	import common.displays.Popup;
	import events.displays.SeasonEventAnnouncement;
	import events.GameEvent;
	import model.Game;
	import net.flashpunk.graphics.Text;
	import time.Season;
	
	/**
	 * An event triggered by a particular season
	 * @author beyamor
	 */
	public class SeasonalEvent implements GameEvent 
	{
		public var season:Season;
		public var moneyAward:uint;
		public var description:String;
		
		public function SeasonalEvent(season:Season, moneyAward:uint, description:String)
		{
			this.season			= season;
			this.moneyAward		= moneyAward;
			this.description	= description;
		}
		
		public function hasOccurred(game:Game):Boolean 
		{
			return (game.data.calendar.season == season);
		}
		
		public function wasAchieved(game:Game):Boolean 
		{
			// TODO: Uhhh
			return true;
		}
		
		public function giveRewards(game:Game):void 
		{
			game.data.addMoney(moneyAward);
		}
		
		public function get announcementDisplay():Display {
			
			return new SeasonEventAnnouncement(this);
		}
		
		public function get achievementDisplay():Display {
			
			// TODO: Better achievement and failure displays
			var display:Popup = new Popup(null, 400, 300);
			display.addGraphic(new Text("Event completed! Earned $" + moneyAward + "."));
			display.clearColor = 0xFF000000; // seriously dude, colours?
			return display;
		}
		
		public function get failureDisplay():Display {
			
			var display:Popup = new Popup(null, 400, 300);
			display.addGraphic(new Text("Event missed!"));
			display.clearColor = 0xFF000000;
			return display;
		}
	}

}