package time 
{
	import common.Assets;
	/**
	 * The actual seasons.
	 * @author beyamor
	 */
	public class Seasons 
	{
		public static const SPRING:Season = new Season(
			"Spring",
			Assets.IMG_EVENT_1,
			"Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.\nQuisque pretium auctor tortor,\neget vulputate lorem pulvinar in.\nSed viverra porttitor."
		);
		
		public static const SUMMER:Season = new Season(
			"Summer",
			Assets.IMG_EVENT_2,
			"Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.\nQuisque pretium auctor tortor,\neget vulputate lorem pulvinar in.\nSed viverra porttitor."
		);
		
		public static const FALL:Season = new Season(
			"Fall",
			Assets.IMG_EVENT_3,
			"Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.\nQuisque pretium auctor tortor,\neget vulputate lorem pulvinar in.\nSed viverra porttitor."
		);
		
		public static const WINTER:Season = new Season(
			"Winter",
			Assets.IMG_EVENT_4,
			"Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.\nQuisque pretium auctor tortor,\neget vulputate lorem pulvinar in.\nSed viverra porttitor."
		);
		
		public static const FIRST:Season = SPRING;
		
		private static const ALL_SEASONS:Vector.<Season> = new <Season>[SPRING, SUMMER, FALL, WINTER];
		
		public static function get NUMBER_OF_SEASONS():uint { return ALL_SEASONS.length; }
		
		public static function next(season:Season):Season {
			
			var seasonIndex:int = ALL_SEASONS.indexOf(season);
			if (seasonIndex < 0) throw new Error("Unknown season " + season.name);
			
			var nextSeasonIndex:int = (seasonIndex + 1) % NUMBER_OF_SEASONS;
			
			return ALL_SEASONS[nextSeasonIndex];
		}
	}

}