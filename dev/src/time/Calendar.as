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
		
		public static const SEASON_NAME:Vector.<String> = new <String>[
			"Spring",
			"Summer",
			"Fall",
			"Winter"
		];
		
		public static const SEASON_PICTURE:Vector.<Class> = new <Class>[
			Assets.IMG_EVENT_1,
			Assets.IMG_EVENT_2,
			Assets.IMG_EVENT_3,
			Assets.IMG_EVENT_4
		];
	}

}