package events.instruments 
{
	import events.world.SeasonalEvent;
	import model.Game;
	import hex.HexData;
	import model.Game;
	import observatory.DataTypes;
	import observatory.Instrument;
	import observatory.ObservatoryComponent;
	import time.Seasons;
	import map.terrain.FeatureBuilder;
	import net.flashpunk.graphics.Image;
	import common.Assets;
	import hex.terrain.Terrain;
	import hex.terrain.Types;
	import map.terrain.LocationPoint;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class BuyFirstInstrument extends SeasonalEvent 
	{
		
		public function BuyFirstInstrument() 
		{//							"										  "	
			super(Seasons.FALL, 0, "You'll need more money to get another node.\n"
									+"Luckily, there are many scientists interested\n"
									+"in NEPTUNE's research and will pay to\n"
									+"support it's growth if it shows promising\n" 
									+"data.  To demonstrate this, you will have\n"
									+"to add new instruments to the array.  Go\n"
									+"to the store and buy an instrument, then\n"
									+"place it at the node.");
		}
		
		override public function wasAnnounced(game:Game):void
		{
			game.data.FinishStoreList();
		}
		
		override public function wasAchieved(game:Game):Boolean 
		{
			// Check for an instrument somewhere in the array.
			for each (var hexData:HexData in game.data.hexes) {
				
				for each (var observatoryComponent:ObservatoryComponent in hexData.observatoryComponents) {
					
					if (observatoryComponent is Instrument) return true;
				}
			}
			
			return false;
		}
		
	}

}