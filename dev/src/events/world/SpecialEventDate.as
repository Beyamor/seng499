package events.world 
{
	import events.GameEvent;
	import time.Calendar;
	import time.Season;
	/**
	 * Helper class so we can associate events with dates
	 * I would declare it as an innner class, but AS's compilation model is apparently wildly unfriendly to inners in a static context.
	 */
	public class SpecialEventDate 
	{
		private var season:Season;
		private var year:uint;
		public var event:GameEvent;
		
		public function SpecialEventDate(triggerSeason:Season, triggerYear:uint, event:GameEvent) {
			
			season		= triggerSeason;
			year		= triggerYear;
			this.event	= event;
		}
		
		public function isTriggered(calendar:Calendar):Boolean {
			
			return (season == calendar.season) && (year == calendar.year);
		}
	}

}