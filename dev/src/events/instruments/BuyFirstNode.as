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
	import common.displays.Display;
	import common.displays.Popup;
	import events.displays.SeasonEventAnnouncement;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class BuyFirstNode extends SeasonalEvent 
	{
		
		public function BuyFirstNode() 
		{//								"									"
			super(Seasons.SUMMER, 0, "Congradulations!  The governmant of\n"
										+"Canada has given you a substantial\n"
										+"grant to build an ocean obervatory:\n"
										+"a network of undersea instruments \n"
										+"connected to the internet through a\n"
										+"series of cables and nodes.  To \n"
										+"start your observatory, you will\n"
										+"need to purchace a node and place\n"
										+"it on the map.");
			
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
		
		override public function get achievementDisplay():Display {
			
			var display:Popup = new Popup(null, 380, 300);
			//							"								"
			display.addGraphic(new Text("Well done.  Now you have a \n"
										+"starting point for the rest\n"
										+"of your network.  Now it's\n"
										+"time to start adding\n"
										+"instruments."));
			display.clearColor = 0xFF000000; // seriously dude, colours?
			return display;
		}
		
		override public function get failureDisplay():Display {
			
			var display:Popup = new Popup(null, 380, 300);
			//							"								"
			display.addGraphic(new Text("Woops.  You will need to \n" 
										+"purchace and place a node to\n"
										+"build your network."));
			display.clearColor = 0xFF000000;
			return display;
		}
	}

}