package time 
{
	import common.Assets;
	/**
	 * ...
	 * @author beyamor
	 * 
	 * This daiguren be all about dates and shwatevs.
	 */
	public class Calendar 
	{
		
		private var _season:Season;
		private var _year:int;
		
		public function get season():Season { return _season; }
		public function get year():int { return _year; }
		
		public function Calendar(year:int = 0, season:Season = null)
		{
			this._season = season? season : Season.FIRST_SEASON;
			this._year	= year;
		}
		
		private function goToNextYear():void {
			
			++_year;
		}
		
		public function goToNextSeason():void {
			
			_season = Season.next(_season);
			
			if (_season == Season.FIRST_SEASON) goToNextYear();
		}
	}

}