package  
{
	import hex.controllers.TileViewer;
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
				
		public function Instrument(instrument:InstrumentData, tile:HexTile) 

		{
			this.instrument = instrument;
			this.tile = tile;
		}
		
		override public function getName():String
		{
			return instrument.getName();
		}
		
		public function getTile():HexTile {
			return tile;
		}
	}

}