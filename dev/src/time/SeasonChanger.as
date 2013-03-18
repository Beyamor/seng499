package time 
{
	import data.DataConverter;
	import data.DataTally;
	import events.WorldEvent;
	import model.Game;
	/**
	 * This guy wraps up whatever happens to the game models when a season changes.
	 * @author beyamor
	 */
	public class SeasonChanger 
	{
		private var game:Game;
		
		public function SeasonChanger(game:Game)
		{
			this.game = game;
		}
		
		public function changeSeason():void {
			
			var dataTally:DataTally		= new DataTally(game.data);
			var moneyValue:uint			= new DataConverter(dataTally.sum).moneyValue;
			
			game.data.calendar.goToNextSeason();
			game.data.addMoney(moneyValue);
			
			var worldEvents:Vector.<WorldEvent> = game.data.worldEvents.concat(); // Copy so we can remove events
			for each (var event:WorldEvent in worldEvents) {
				
				if (event.hasOccurred(game)) {
					
					if (event.wasAchieved(game)) event.giveRewards(game);

					game.data.worldEvents.splice(game.data.worldEvents.indexOf(event), 1);
				}
			}
		}
	}

}