package  
{
	import hex.HexTile;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Instrument 
	{
		private var name:String;
		private var tile:hex.HexTile;
		public function Instrument(name:String, tile:hex.HexTile) 
		{
			this.name = name;
			this.tile = tile;
		}
		
		public function getName():String
		{
			return name;
		}
	}

}