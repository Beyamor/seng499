package observatory
{
	import adobe.utils.CustomActions;
	import data.DataSample;
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
        public var isProducingData:Boolean;
		public var sample:DataSample;
		
		private var _interestingEventIsOccurring:Boolean = false;
		public function get interestingEventIsOccurring():Boolean { return _interestingEventIsOccurring; }
				
		public function Instrument(instrument:ComponentData, tile:HexTile) 

		{
			super(instrument);
			//this.component = instrument;
			this.tile = tile;

			isProducingData = instrument.properties.producesDataFor(tile.data.terrain);
			sample = GameTables.boringDataSampleCollection[dataType][0];
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
		
		public function get dataDescription():String {
			
			/*return interestingEventIsOccurring?
						component.properties.interestingDataDescription
						: component.properties.dataDescription;*/
			return sample.description;
		}
		
		public function getDataValue():int {
			return component.properties.dataValue
		}
		
		public function get mediaClip():Class//Not sure what this should be
		{
			return sample.media;
		}
		
		public function setDataSample(sample:DataSample):void
		{
			this.sample = sample;
		}
	}

}
