package observatory
{
	import hex.controllers.TileViewer;
	import hex.HexTile;
        import model.GameTables;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Instrument extends ObservatoryComponent
	{
		private var tile:HexTile;
		private var instrument:ComponentData
		public var id:int;
                public var isProducingData:Boolean;
				
		public function Instrument(instrument:ComponentData, tile:HexTile) 

		{
			this.instrument = instrument;
			this.tile = tile;

                        isProducingData = GameTables.instrumentProperties[id].producesDataFor(tile.data.terrain);
		}
		
		override public function getName():String
		{
			return instrument.getName() + (isProducingData? " - Producing data" : "");
		}
		
		public function getTile():HexTile {
			return tile;
		}
	}

}
