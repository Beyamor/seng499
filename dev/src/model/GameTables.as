package model 
{
	import common.Assets;
        import hex.terrain.Types;
		import observatory.DataTypes;
        import observatory.properties.InstrumentProperties;

	/**
	 * ...
	 * @author Lambwatt
	 */
	public class GameTables 
	{
		
		
                // Ugggh.
                // I would love to make a class for this - InstrumentPropertyList?
                public static var instruments:Vector.<InstrumentProperties> = new Vector.<InstrumentProperties>;
                instruments.push(

                    InstrumentProperties.describe("Node")
						.displayDescription("A node is a central hub of communication between NEPTUNE instruments.")
                        .image(Assets.IMG_NODE)
						.storeImage(Assets.IMG_STORE_NODE)
                        .isNode
						.costs(500/*000*/)
                        .finish(),
						
					InstrumentProperties.describe("Hydraphone")
						.displayDescription("Hydraphones capture audio data. Neat!")
						.dataDescription("This is just audio data. Not that there's anything wrong with that.")
						.interestingDataDescription("You're capturing some interesting data for great science!")
                        .image(Assets.IMG_TESTINSTRUMENT)
						.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
                        .producesDataOnAllTerrain
						.produces(DataTypes.AUDIO)
						.costs(50/*000*/)
                        .finish(),
						
					InstrumentProperties.describe("CTD")
						.displayDescription("A CTD!")
						.dataDescription("CTDs capture conductivity, temperature, and depth.")
						.interestingDataDescription("Oh my! Look at that huge drop in depth and temperature!")
                        .image(Assets.IMG_TESTINSTRUMENT)
						.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
						.producesDataOnAllTerrain
						.produces(DataTypes.CTD_DATA)
						.costs(100/*000*/)
                        .finish(),
						
					InstrumentProperties.describe("Camera")
						.displayDescription("Takes video of things under the ocean.")
						.dataDescription("High definition video streams available 24/7 on the Internet.")
						.interestingDataDescription("What is going on in that video stream!?")
                        .image(Assets.IMG_TESTINSTRUMENT)
						.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
						.producesDataOnAllTerrain
						.produces(DataTypes.VIDEO)
						.costs(200/*000*/)
                        .finish(),
						
					InstrumentProperties.describe("ADCP")
						.displayDescription("Acoustic doppler current profiler")
						.dataDescription("similar to a sonar, attempting to measure water current velocities over a depth range using the Doppler effect of sound waves scattered back from particles within the water column")
						.interestingDataDescription("Check out that effect! So doppler!")
                        .image(Assets.IMG_TESTINSTRUMENT)
						.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
						.producesDataOnAllTerrain
						.produces(DataTypes.PROFILES)
						.costs(400000)
                        .finish()
                );
				
				public static function instrumentIDByName(name:String):uint {
					
					name = name.toLowerCase();
					
					// TODO: Think about why these things aren't keyed by name anyway
					for (var id:int = 0; id < instruments.length; ++id) {
						
						if (instruments[id].name.toLowerCase() == name) return id;
					}
					
					throw new Error("Unknown instrument name: " + name);
				}
				
				public static function instrumentByName(name:String):InstrumentProperties {
					
					return instruments[instrumentIDByName(name)];
				}
	}

}
