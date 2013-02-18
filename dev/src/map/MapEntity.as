package map 
{
	
	import common.Assets;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class MapEntity extends Entity
	{
		
		public function MapEntity(x:int, y:int) 
		{
			super(x, y);
			graphic = new Image(Assets.IMG_MAP);
		}
		
	}

}