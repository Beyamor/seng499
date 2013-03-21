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
	}

}