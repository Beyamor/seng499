package events.instruments 
{
	import events.displays.EventResultPopup;
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
	import common.displays.Display;
	import common.displays.Popup;
	import events.displays.SeasonEventAnnouncement;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class BuyFirstInstrument extends SeasonalEvent 
	{
		
		public function BuyFirstInstrument() 
		{//							"										  "	
			super(Seasons.FALL, 0, "You'll need more money to get another\n"
									+"node. Luckily, there are many scientists\n"
									+"interested in NEPTUNE's research and will\n"
									+"pay to support it's growth if it shows\n"
									+"promising data.  To demonstrate this, you\n" 
									+"will have to add new instruments to the\n"
									+"array.  Go to the store and buy an \n"
									+"instrument, then place it at the node.\n");
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
		
		override public function get achievementDisplay():Display {
			
			//							"								"
			return new EventResultPopup("Well done.  Now that you have\n"
										+"the hang of it, Keep adding\n"
										+"to the array so you can add a\n"
										+"node near the reef.");
		}
		
		override public function get failureDisplay():Display {
			
			//							"								"
			return new EventResultPopup("Woops.  If you don't have any\n"
										+"instruments, you can't \n"
										+"demonstrate the network's\n"
										+"potential for research.  Try\n"
										+"buying an instrument and adding\n"
										+"it to your node to raise\n"
										+"interest and money.");
		}
		
	}

}