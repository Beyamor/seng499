package  
{
	import hex.HexTile;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Instrument extends ObservatoryComponent
	{
		private var name:String;
		private var tile:hex.HexTile;
		private var instrument:InstrumentData
		public var id:int;
				
		public function Instrument(instrument:InstrumentData) 
		{
			this.name = name;
			this.tile = tile;	
			this.id = id;
		}
		
		override public function getName():String
		{
			return name;
		}
	}

}