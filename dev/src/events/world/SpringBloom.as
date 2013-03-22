package events.world 
{
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
	 * @author beyamor
	 */
	public class SpringBloom extends SeasonalEvent 
	{
		
		public function SpringBloom() 
		{
			//							"								"
			super(Seasons.SUMMER, 500, "The Spring Bloom will happen next spring.\n"
										+"Get a camera on a reef to capture the\n"
										+"event!");
			
		}
		
		override public function wasAnnounced(game:Game):void
		{
			game.data.addTerrainFeature(new FeatureBuilder()	.setImage(new Image(Assets.IMG_SEALIFE))
																.setLocationStructure(new LocationPoint(1000, 400))
																.setImageCoordinates(974, 374)
																.setRange(300)
																.setTerrainForceSpread(1)
																.setTerrainInitialForce(4)
																.setTerrainTile(new Terrain(Types.REEF))
																.build());
			
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
		
		override public function get achievementDisplay():Display {
			
			// TODO: Better achievement and failure displays
			var display:Popup = new Popup(null, 380, 300);
			//							"								"
			display.addGraphic(new Text("Excellent! The video from the\n"
										+"reef is some of the most\n"
										+"amazing ever captured.  The\n"
										+"science communityhas donated\n"
										+"$" + moneyAward + " to develop\n"
										+"the observatory."));
			display.clearColor = 0xFF000000; // seriously dude, colours?
			return display;
		}
		
		override public function get failureDisplay():Display {
			
			var display:Popup = new Popup(null, 380, 300);
			//							"								"
			display.addGraphic(new Text("We fell short of our goal to\n"
										+"capture reef video by this\n"
										+"Summer.  We'll have to\n"
										+"continue buildingand try to\n"
										+"gather more support for the\n"
										+"project."));
			display.clearColor = 0xFF000000;
			return display;
		}
	}

}