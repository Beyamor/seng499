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
		private var data:Class = Instrument;
		private var image:Image;
		//private var screenX:int = 600;
		
		public function InstrumentData(name:String, image:Image/*, instrument:Class*/) 
		{
			this.name = name;
			this.image = image;

		}
		
		public function getTextAt(x:int, y:int):Text
		{
			var txt:Text = new Text(name);
			txt.x = x;
			txt.y = y;
			txt.color = 0x000000;
			return txt;
		}
		
		public function getImageAt(x:int, y:int):Image
		{
			var img:Image = new Image(image);
			img.x = x;
			img.y = y;
			return img;
		}
		
		public function getInstrument():Instrument
		{
			return(new data(name));
		}
		
		public function getNameString():String
		{
			return (name);
		}
	}
}