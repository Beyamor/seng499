package events.world 
{
	import events.GameEvent;
	import flash.accessibility.ISearchableText;
	import model.Game;
	import time.Calendar;
	import time.Season;
	import time.Seasons;
	import events.instruments.BuyFirstInstrument;
	import events.instruments.BuyFirstNode;
	/**
	 * Special hard-coded events
	 * @author beyamor
	 */
	public class SpecialEvents 
	{
		private static var DATE_TRIGGERED_EVENTS:Vector.<SpecialEventDate> = new <SpecialEventDate>[

		//new SpecialEventDate(Seasons.SPRING, 0,
		//	new BuyFirstNode()),
		
		// Spring bloom
		new SpecialEventDate(Seasons.SUMMER, 0,
			new SpringBloom()), 
		
		new SpecialEventDate(Seasons.SUMMER, 0,
			new BuyFirstInstrument())
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