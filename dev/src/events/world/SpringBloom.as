package events.world 
{
	import events.displays.EventResultPopup;
	import hex.displays.HexDisplay;
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
		
		public var instrument:Instrument = null;
		public var game:Game = null;
		public var hexData:HexData = null;
		
		public function SpringBloom() 
		{
			//							"								"
			super(Seasons.SUMMER, 500000, "The Spring Bloom will happen next spring.\n"
										+"Get a camera on a reef to capture the\n"
										+"event!");
			
		}
		
		override public function wasAnnounced(game:Game):void
		{
			game.data.addTerrainFeature(new FeatureBuilder()	.setImage(new Image(Assets.IMG_SEALIFE))
																.setLocationStructure(new LocationPoint(1000, 400))
																.setImageCoordinates(974, 374)
																.setRange(100)
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
						
						if (instrument.dataType == DataTypes.VIDEO && hexData.terrain.type == Types.REEF) 
						{
							/*this.game = game;
							this.hexData = hexData;
							this.instrument = instrument;*/
							return true;
						}
					}
				}
			}
			
			return false;
		}
		
		override public function get achievementDisplay():Display {
			
			//							"								"
			return new EventResultPopup("Excellent! The video from the\n"
										+"reef is some of the most\n"
										+"amazing ever captured.  The\n"
										+"science communityhas donated\n"
										+"$" + moneyAward + " to develop\n"
										+"the observatory.");
		}
		
		override public function get failureDisplay():Display {
			
			var display:Popup = new Popup(null, 380, 300);
			//							"								"
			return new EventResultPopup("We fell short of our goal to\n"
										+"capture reef video by this\n"
										+"Summer.  We'll have to\n"
										+"continue buildingand try to\n"
										+"gather more support for the\n"
										+"project.");
		}
	}

}