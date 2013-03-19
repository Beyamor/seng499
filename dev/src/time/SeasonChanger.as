package time 
{
	import data.DataConverter;
	import data.DataTally;
	import events.displays.SeasonEventAnnouncement;
	import events.world.SeasonalEvent;
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
					
					if (event.wasAchieved(game)) event.giveRewards(game);

					game.data.worldEvents.splice(game.data.worldEvents.indexOf(event), 1);
				}
			}
			
			// Predefined, hardcoded events
			if (calendar.season == Seasons.SUMMER && calendar.year == 0) {
				
				var springBloom:SeasonalEvent = new SeasonalEvent(Seasons.SPRING, 500, "The Spring Bloom will happen next spring.\nGet you some.");
				
				game.data.worldEvents.push(springBloom);
				game.state.pushEventDisplay(new SeasonEventAnnouncement(springBloom));
			}
		}
	}

}