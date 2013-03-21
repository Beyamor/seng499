package events.world 
{
	import hex.HexData;
	import model.Game;
	import observatory.ObservatoryComponent;
	import time.Seasons;
	/**
	 * ...
	 * @author beyamor
	 */
	public class SpringBloom extends SeasonalEvent 
	{
		
		public function SpringBloom() 
		{
			super(Seasons.SUMMER, 500, "The Spring Bloom will happen next spring.\nGet a camera on a reef to capture the event!");
		}
		
		override public function wasAchieved(game:Game):Boolean 
		{
			/*for each (var hexData:HexData in game.data.hexes) {
				
				for each (var observatoryComponent:ObservatoryComponent in hexData.observatoryComponents) {
					
					
				}
			}*/
			return false;
		}
	}

}