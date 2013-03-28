package observatory
{
	import adobe.utils.CustomActions;
	import common.Assets;
	import common.Collections;
	import data.DataSample;
	import hex.controllers.TileViewer;
	import hex.HexTile;
	import hex.terrain.Types;
    import model.GameTables;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Instrument extends ObservatoryComponent
	{
		private var tile:HexTile;
        public var isProducingData:Boolean;
		
		private var _sample:DataSample;
		public function get sample():DataSample { return _sample; }
		
		private var _interestingEventIsOccurring:Boolean = false;
		public function get interestingEventIsOccurring():Boolean { return _interestingEventIsOccurring; }
				
		public function Instrument(instrument:ComponentData, tile:HexTile) 

		{
			super(instrument);
			//this.component = instrument;
			this.tile = tile;

			isProducingData = instrument.properties.producesDataFor(tile.data.terrain);
			
			if (component.dataType == DataTypes.VIDEO && tile.data.terrain.type == Types.REEF)
				_sample = new DataSample(Assets.IMG_VIDEOREEF, false, "Diverse life is visible on the reef with\n the video camera.");
			else
				_sample = Collections.any(GameTables.boringDataSampleCollection[dataType]);
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
			_sample = Collections.any(GameTables.interestingDataSampleCollection[dataType]);
		}
		
		public function endSeason():void {
		
			// This is under the assumption that a special instrument event only lasts one season.
			_interestingEventIsOccurring = false;
			
			//Extreme hack, but i think the reef should hava special result
			if (component.dataType == DataTypes.VIDEO && tile.data.terrain.type == Types.REEF)
			{
				_sample = new DataSample(Assets.IMG_VIDEOREEF, false, "Diverse life is visible on the reef with\n the video camera.")
			}
			else{
			// Randomize the sample. Note that even if it was an interesting one, it'll be set back to a boring one.
			_sample = Collections.any(GameTables.boringDataSampleCollection[dataType]);
			}
		}
		
		public function get dataDescription():String {
			
			return sample.description;
		}
		
		public function getDataValue():int {
			return component.properties.dataValue
		}
		
		public function get mediaClip():Class//Not sure what this should be
		{
			return sample.media;
		}
	}

}
