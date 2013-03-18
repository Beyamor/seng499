package events.world 
{
	import events.WorldEvent;
	import model.Game;
	
	/**
	 * An event triggered by a particular season
	 * @author beyamor
	 */
	public class SeasonalEvent implements WorldEvent 
	{
		private var season:uint;
		private var moneyAward:uint;
		
		public function SeasonalEvent(season:uint, moneyAward:uint)
		{
			this.season		= season;
			this.moneyAward	= moneyAward;
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
		
	}

}