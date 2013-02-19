package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import model.GameTables;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InstrumentData 
	{
		private var key:uint;
		
		public function InstrumentData(key:uint) 
		{
			this.key = key;
		}
		
		public function getText():Text
		{
			return new Text(getNameString());
		}
		
		public function getImage():Image 
		{
			return new Image(GameTables.instrumentImages[key]);
		}
		
		public function getNameString():String
		{
            return GameTables.instrumentNames[key];
		}
	}
}
