package events.world 
{
	import hex.HexData;
	import model.Game;
	import observatory.DataTypes;
	import observatory.Instrument;
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
			// Check for something producing video on a reef
			// This is going to be pretty ad hoc. Probably worth formalizing terrain and instrument queries.
			for each (var hexData:HexData in game.data.hexes) {
				
				for each (var observatoryComponent:ObservatoryComponent in hexData.observatoryComponents) {
					
					if (observatoryComponent is Instrument) {
						
						var instrument:Instrument = observatoryComponent as Instrument;
						
						if (instrument.dataType == DataTypes.VIDEO) return true;
					}
				}
			}
			
			return false;
		}
	}

}