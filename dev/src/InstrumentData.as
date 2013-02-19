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
		private var image:Image;
		private var key:uint;
		
		public function InstrumentData(key:uint) 
		{
			this.key = key;
		}
		
		public function getTextAt(x_offset:int, y_offset:int):Text
		{
			var txt:Text = new Text(getName());
			txt.x = x_offset;
			txt.y = y_offset;
			txt.color = 0x000000;
			return txt;
		}
		
		public function getImageAt(x_offset:int, y_offset:int):Image
		{
			var img:Image = new Image(GameTables.instrumentImages[key]);
			img.x = x_offset;
			img.y = y_offset;
			return img;
		}
		
		public function getName():String
		{
            return GameTables.instrumentNames[key];
		}
	}
}
