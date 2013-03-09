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

                    InstrumentProperties.describe("A")
                        .image(Assets.IMG_TESTINSTRUMENT)
                        .producesDataOn(hex.terrain.Types.SAND)
                        .finish(),

                    InstrumentProperties.describe("Node")
                        .image(Assets.IMG_NODE)
                        .isNode()
                        .finish()
                );
				
				public static function getInstrumentIDByName(name:String):uint {
					
					name = name.toLowerCase();
					
					// TODO: Think about why these things aren't keyed by name anyway
					for (var id:int = 0; id < instruments.length; ++id) {
						
						if (instruments[id].name.toLowerCase() == name) return id;
					}
					
					throw new Error("Unknown instrument name: " + name);
				}
	}

}
