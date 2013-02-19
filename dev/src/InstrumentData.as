package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InstrumentData 
	{
		private var name:String;
		private var image:Image;
		//private var screenX:int = 600;
		
		public function InstrumentData(name:String, image:Image) 
		{
			this.name = name;
			this.image = image;

		}
		
		public function getTextAt(x_offset:int, y_offset:int):Text
		{
			var txt:Text = new Text(name);
			txt.x = x_offset;
			txt.y = y_offset;
			txt.color = 0x000000;
			return txt;
		}
		
		public function getImageAt(x_offset:int, y_offset:int):Image
		{
			var img:Image = new Image(image);
			img.x = x_offset;
			img.y = y_offset;
			return img;
		}
		
		public function getInstrument():Instrument
		{
			return null;//(new data(name));
		}
		
		public function getNameString():String
		{
			return (name);
		}
	}
}