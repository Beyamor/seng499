package events.world 
{
	import events.WorldEvent;
	import flash.accessibility.ISearchableText;
	import time.Calendar;
	import time.Season;
	import time.Seasons;
	/**
	 * Special hard-coded events
	 * @author beyamor
	 */
	public class SpecialEvents 
	{
		private static var DATE_TRIGGERED_EVENTS:Vector.<SpecialEventDate> = new <SpecialEventDate>[

		// Spring bloom
		new SpecialEventDate(Seasons.SUMMER, 0,
			new SeasonalEvent(Seasons.SPRING, 500, "The Spring Bloom will happen next spring.\nGet you some."))
		]
		
		public static function triggeredByDate(calendar:Calendar):Vector.<WorldEvent> {
			
			var triggeredEvents:Vector.<WorldEvent> = new Vector.<WorldEvent>;
			
			for each (var eventDate:SpecialEventDate in DATE_TRIGGERED_EVENTS) {
				
				if (eventDate.isTriggered(calendar)) triggeredEvents.push(eventDate.event);
			}
			
			return triggeredEvents;
		}
	}
}