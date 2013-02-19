package  
{
	import hex.HexTile;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Instrument extends ObservatoryComponent
	{
		private var tile:HexTile;
		private var instrument:InstrumentData
		public var id:int;
				
		public function Instrument(intstrument:InstrumentData, tile:HexTile) 
		{
			this.instrument = instrument;
			this.tile = tile;
		}
		
		public function getName():String
		{
			return instrument.getNameString();
		}
	}

}