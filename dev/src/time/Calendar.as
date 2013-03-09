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
		
		private var _season:int	= 0;
		private var _year:int	= 0;
		
		public function get season():int { return _season; }
		public function get year():int { return _year; }
		
		public function Calendar(year:int = 0, season:int = 0)
		{
			this._season = season;
			this._year	= year;
		}
		
		private function goToNextYear():void {
			
			++_year;
			_season = 0;
		}
		
		public function goToNextSeason():void {
			
			++_season;
			
			if (_season >= NUMBER_OF_SEASONS) goToNextYear();
		}
	}

}