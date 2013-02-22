package model 
{
	import common.Assets;
        import hex.terrain.Types;
        import observatory.InstrumentProperties;

	/**
	 * ...
	 * @author Lambwatt
	 */
	public class GameTables 
	{
		public static var instrumentImages:Vector.<Class> = new Vector.<Class>;
		public static var instrumentNames:Vector.<String> = new Vector.<String>;
		public static var instrumentIsNode:Vector.<Boolean> = new Vector.<Boolean>;
		
		instrumentNames.push("A");
		instrumentImages.push(Assets.IMG_TESTINSTRUMENT);
		instrumentIsNode.push(false);
			
		instrumentNames.push("Node");
		instrumentImages.push(Assets.IMG_NODE);
		instrumentIsNode.push(true);

		public static var instrumentProperties:Object = {

                    0:          new InstrumentProperties()
                                    .producesDataOn(hex.terrain.Types.SAND),

                    1:          new InstrumentProperties()
                };
	}

}
