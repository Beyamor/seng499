package observatory
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class ObservatoryComponent 
	{
		protected var component:ComponentData;
		private var name:String = "undifferentiated component";
		public function ObservatoryComponent(d:ComponentData)
		{
			component = d;
		}
		
		public function getName():String
		{
			return name;
		}
		
		public function isSeenFromHexGrid():Boolean
		{
			return component.isSeenInHexGrid();
		}
		
		public function getImage():Image
		{
			return component.getImage();//TODO: make this a copy instead.  For now, Do NOT modify
		}
		
		public function isNode():Boolean 
		{
			return component.isNode();
		}
		
		public function get description():String {
			
			return component.properties.description;
		}
	}

}
