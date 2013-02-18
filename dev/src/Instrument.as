package  
{
	import hex.HexTile;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Instrument extends Placable
	{
		private var name:String;
		private var tile:hex.HexTile;
		public function Instrument(name:String, tile:hex.HexTile) 
		{
			super(0, 0, 0);
			this.name = name;
			this.tile = tile;
		}
		
		public function getName():String
		{
			return name;
		}
	}

}