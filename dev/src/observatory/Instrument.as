package observatory
{
	import adobe.utils.CustomActions;
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
		public var id:int;
        public var isProducingData:Boolean;
		
		private var _interestingEventIsOccurring:Boolean = false;
		public function get interestingEventIsOccurring():Boolean { return _interestingEventIsOccurring; }
				
		public function Instrument(instrument:ComponentData, tile:HexTile) 

		{
			super(instrument);
			//this.component = instrument;
			this.tile = tile;

			isProducingData = GameTables.instruments[id].producesDataFor(tile.data.terrain);
		}
		
		override public function getName():String
		{
			return component.getName();
		}
		
		// Let me mention that appending the producing data thing to the name
		// shouldn't stick around. That's just a temporary display thing.
		//public function getStatusString():String
		//{
			//return component.getName() + (isProducingData? " - Recording data" : " - Recording Noise");
		//}
		
		public function getTile():HexTile {
			return tile;
		}
		
		public function get dataType():String {
			
			return component.dataType;
		}
		
		public function startInterestingEvent():void {
			
			_interestingEventIsOccurring = true;
		}
		
		public function endInterestingEvent():void {
			
			_interestingEventIsOccurring = false;
		}
	}

}
