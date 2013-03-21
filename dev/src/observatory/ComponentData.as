package observatory
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import model.GameTables;
	import observatory.properties.InstrumentProperties;
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
		
		public function getStoreImage():Image 
		{
			return new Image(GameTables.instruments[key].storeImage);
		}
		
		public function getName():String
		{
            return GameTables.instruments[key].name;
		}
		
		public function isNode():Boolean
		{
			return GameTables.instruments[key].isNode;
		}
		
		public function isSeenInHexGrid():Boolean
		{
			return GameTables.instruments[key].isSeenOnHexGrid;
		}	
	
		public function get dataType():String {
			
			return GameTables.instruments[key].dataType;
		}
		
		/**
		 * Is the component data deprecated with the introduction of instrument properties? 
		 * For the sake of not writing a bunch of accessors, I'm just going to access the properties directly.
		 */
		public function get properties():InstrumentProperties {
			
			return GameTables.instruments[key];
		}
	}
}
