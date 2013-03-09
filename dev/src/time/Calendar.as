package time 
{
	/**
	 * ...
	 * @author beyamor
	 * 
	 * This daiguren be all about dates and shwatevs.
	 */
	public class Calendar 
	{
		public static const NUMBER_OF_SEASONS:uint = 4;
		
		private var season:int	= 0;
		private var year:int	= 0;
		
		public function Calendar(year:int = 0, season:int = 0)
		{
			this.season = season;
			this.year	= year;
		}
		
		private function goToNextYear():void {
			
			++year;
			season = 0;
		}
		
		public function goToNextSeason():void {
			
			++season;
			
			if (season >= NUMBER_OF_SEASONS) goToNextYear();
		}
	}

}