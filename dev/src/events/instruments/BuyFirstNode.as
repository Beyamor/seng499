package events.instruments 
{
	import events.world.SeasonalEvent;
	import model.Game;
	import hex.HexData;
	import model.Game;
	import observatory.DataTypes;
	import observatory.Node;
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
	public class BuyFirstNode extends SeasonalEvent 
	{
		
		public function BuyFirstNode() 
		{//								"										"
			super(Seasons.SUMMER, 100, "Congradulations!  The governmant of Canada\n"
										+"has given you a substantial grant to build\n"
										+"an ocean obervatory: a network of undersea\n"
										+"instruments connected to the internet\n"
										+"through a series of cables and nodes.\n"
										+"To start your observatory, you will\n"
										+"need to purchace a node and place it\n"
										+"on the map.");
			
		}
		
		override public function wasAchieved(game:Game):Boolean 
		{
			//Check if a Node was Placed
			for each (var hexData:HexData in game.data.hexes) {
				
				for each (var observatoryComponent:ObservatoryComponent in hexData.observatoryComponents) {
					
					if (observatoryComponent is Node) return true;
				}
			}
			
			return false;
		}
		
	}

}