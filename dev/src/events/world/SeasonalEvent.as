package events.world 
{
	import events.WorldEvent;
	import model.Game;
	import time.Season;
	
	/**
	 * An event triggered by a particular season
	 * @author beyamor
	 */
	public class SeasonalEvent implements WorldEvent 
	{
		public var season:Season;
		public var moneyAward:uint;
		public var description:String;
		
		public function SeasonalEvent(season:Season, moneyAward:uint, description:String)
		{
			this.season			= season;
			this.moneyAward		= moneyAward;
			this.description	= description;
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