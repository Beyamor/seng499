package hex.entities 
{
	import hex.HexTile;
	import net.flashpunk.Entity;
	import observatory.ObservatoryComponent;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class HexComponentEntity extends Entity 
	{
		public var component:ObservatoryComponent;
		public var image:Image;
		protected var tile:HexTile;
		
		public function HexComponentEntity(component:ObservatoryComponent, tile:HexTile) 
		{
			this.tile = tile;
			this.component = component;
			image = component.getImage();
			width = image.width;
			height = image.height;
			graphic = image;
			layer = 1;
		}
		
		public function containsPoint(x:int, y:int):Boolean
		{
			if (x < this.x+width && x > this.x && y < this.y+height && y > this.y)
				return true;
			return false;
		}
	}

}