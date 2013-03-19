package map.terrain 
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class TerrainImageEntity extends Entity
	{
		
		public function TerrainImageEntity(feature:Feature) 
		{
			graphic = feature.mapImage;
			super(feature.x, feature.y)
		}
		
	}

}