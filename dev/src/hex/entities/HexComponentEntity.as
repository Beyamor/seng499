package hex.entities 
{
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
		
		public function HexComponentEntity(component:ObservatoryComponent, x:int, y:int) 
		{
			super(x,y)
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