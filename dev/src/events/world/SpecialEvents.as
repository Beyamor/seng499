package events.world 
{
	import events.GameEvent;
	import flash.accessibility.ISearchableText;
	import model.Game;
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
			new SpringBloom())
		]

		public static function triggeredByDate(calendar:Calendar):Vector.<GameEvent> {
			
			var triggeredEvents:Vector.<GameEvent> = new Vector.<GameEvent>;
			
			for each (var eventDate:SpecialEventDate in DATE_TRIGGERED_EVENTS) {
				
				if (eventDate.isTriggered(calendar)) triggeredEvents.push(eventDate.event);
			}
			
			return triggeredEvents;
		}
	}
}