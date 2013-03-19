package model 
{
	import common.Assets;
        import hex.terrain.Types;
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
                        .image(Assets.IMG_NODE)
						.storeImage(Assets.IMG_STORE_NODE)
                        .isNode()
						.isSeenOnHexGrid()
						.costs(50)
                        .finish(),
						
					InstrumentProperties.describe("Hydraphone")
                        .image(Assets.IMG_TESTINSTRUMENT)
						.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
                        .producesDataOn(Types.MUD, Types.NOT_MUD, Types.REEF)
						.isSeenOnHexGrid()
						.costs(40)
                        .finish(),
						
					InstrumentProperties.describe("CTB")
                        .image(Assets.IMG_TESTINSTRUMENT)
						.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
                        .producesDataOn(Types.MUD, Types.NOT_MUD, Types.REEF)
						.isSeenOnHexGrid()
						.costs(70)
                        .finish(),
						
					InstrumentProperties.describe("Camera")
                        .image(Assets.IMG_TESTINSTRUMENT)
						.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
                        .producesDataOn(Types.MUD, Types.NOT_MUD, Types.REEF)
						.isSeenOnHexGrid()
						.costs(100)
                        .finish(),
						
					InstrumentProperties.describe("ADCR")
                        .image(Assets.IMG_TESTINSTRUMENT)
						.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
                        .producesDataOn(Types.MUD, Types.NOT_MUD, Types.REEF)
						.isSeenOnHexGrid()
						.costs(130)
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
