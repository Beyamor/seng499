package observatory
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import model.GameTables;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class ComponentData 
	{
		private var key:uint;
		
		public function ComponentData(key:uint) 
		{
			this.key = key;
		}
		
		public function getText():Text
		{
			return new Text(getName());
		}
		
		public function getImage():Image 
		{
			return new Image(GameTables.instruments[key].image);
		}
		
		public function getName():String
		{
            return GameTables.instruments[key].name;
		}
		
		public function isNode():Boolean
		{
			return GameTables.instruments[key].isNode;
		}
	}
}
