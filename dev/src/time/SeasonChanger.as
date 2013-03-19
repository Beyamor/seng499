package time 
{
	import data.DataConverter;
	import data.DataTally;
	import events.displays.SeasonEventAnnouncement;
	import events.world.SeasonalEvent;
	import events.world.SpecialEvents;
	import events.WorldEvent;
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
			
			var dataTally:DataTally		= new DataTally(game.data);
			var moneyValue:uint			= new DataConverter(dataTally.sum).moneyValue;
			
			calendar.goToNextSeason();
			game.data.addMoney(moneyValue);
			
			var worldEvents:Vector.<WorldEvent> = game.data.worldEvents.concat(); // Copy so we can remove events
			for each (var event:WorldEvent in worldEvents) {
				
				if (event.hasOccurred(game)) {
					
					if (event.wasAchieved(game)) {
						
						event.giveRewards(game);
						game.state.pushEventDisplay(event.achievementDisplay);
					}
				
					else {
						
						game.state.pushEventDisplay(event.failureDisplay);
					}

					game.data.worldEvents.splice(game.data.worldEvents.indexOf(event), 1);
				}
			}
			
			// Special events triggered by date
			for each (var dateTriggeredEvent:WorldEvent in SpecialEvents.triggeredByDate(calendar)) {
				
				game.data.worldEvents.push(dateTriggeredEvent);
				game.state.pushEventDisplay(dateTriggeredEvent.announcementDisplay);
			}
		}
	}

}