package hex.controllers 
{
	import net.flashpunk.graphics.Image;
	import observatory.ComponentData;
	import observatory.ObservatoryComponent;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class HexSubhitbox 
	{
		public var x:int = 0;
		public var y:int = 0;
		public var component:ObservatoryComponent;
		public var width:int = 0;
		public var height:int = 0;
		public var image:Image;
		
		public function HexSubhitbox(component:ObservatoryComponent) 
		{
			this.component = component;
			image = component.getImage();
			width = image.width;
			height = image.height;
		}
		
		public function containsPoint(x:int, y:int):Boolean
		{
			if (x < this.x+width && x > this.x && y < this.y+height && y > this.y)
				return true;
			return false;
		}
	}

}