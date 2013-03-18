package time 
{
	import data.DataConverter;
	import data.DataTally;
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
		}
	}

}