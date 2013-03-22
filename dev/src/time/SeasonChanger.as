package time 
{
	import data.DataConverter;
	import data.DataTally;
	import events.displays.SeasonEventAnnouncement;
	import events.instruments.InstrumentEventCoordinator;
	import events.world.SeasonalEvent;
	import events.world.SpecialEvents;
	import events.GameEvent;
	import model.Game;
	/**
	 * This guy wraps up whatever happens to the game models when a season changes.
	 * @author beyamor
	 */
	public class SeasonChanger 
	{
		private var game:Game;
		private function get calendar():Calendar { return game.data.calendar; }
		
		public function SeasonChanger(game:Game)
		{
			this.game = game;
		}
		
		public function changeSeason():void {
			
			calendar.goToNextSeason();
			
			// Check active game events
			var GameEvents:Vector.<GameEvent> = game.data.GameEvents.concat(); // Copy so we can remove events
			for each (var event:GameEvent in GameEvents) {
				
				if (event.hasOccurred(game)) {
					
					if (event.wasAchieved(game)) {
						
						event.giveRewards(game);
						game.state.pushEventDisplay(event.achievementDisplay);
					}
				
					else {
						
						game.state.pushEventDisplay(event.failureDisplay);
					}

					game.data.GameEvents.splice(game.data.GameEvents.indexOf(event), 1);
				}
			}
			
			// Special events triggered by date
			for each (var dateTriggeredEvent:GameEvent in SpecialEvents.triggeredByDate(calendar)) {
				
				dateTriggeredEvent.wasAnnounced(game);
				game.data.GameEvents.push(dateTriggeredEvent);
				game.state.pushEventDisplay(dateTriggeredEvent.announcementDisplay);
			}
			
			// Instrument events.
			// Note that this should happen after other events so its messages are lower in the queue
			(new InstrumentEventCoordinator).coordinateEvents(game);
			
			// Cool. Now, get dat sweet cheddar.
			var dataTally:DataTally		= new DataTally(game.data);
			var moneyValue:uint			= new DataConverter(dataTally).totalValue;
			
			game.data.addMoney(moneyValue);
		}
	}

}