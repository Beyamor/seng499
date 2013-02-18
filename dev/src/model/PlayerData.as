package model 
{
	import common.Assets;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class PlayerData 
	{

		public var instrumentsInventory:Vector.<InstrumentData> = new Vector.<InstrumentData>();
		public var storeList:Vector.<InstrumentData> = new Vector.<InstrumentData>();
        private var hexInstruments:Object = new Object;
		
		public function PlayerData()
		{
			populateStoreList();
			addDummyData();
		}
		
		public function printInventory()
		{
			trace("begin");
			for (var i:int; i < instrumentsInventory.length; i++ )
			{
				trace((instrumentsInventory[i]as Instrument).getName());
			}
			trace("end");
		}
		
		public function addToInventory(data:InstrumentData)
		{
			instrumentsInventory.push(data);
		}
		
		public function populateStoreList():void
		{
			storeList.push(new InstrumentData("A", new Image(Assets.IMG_TESTINSTRUMENT)));
			storeList.push(new InstrumentData("B", new Image(Assets.IMG_TESTINSTRUMENT)));
		}
		
		public function addDummyData():void
		{
			addToInventory(new InstrumentData("A", new Image(Assets.IMG_TESTINSTRUMENT)));
			instrumentsInventory.push(new InstrumentData("B", new Image(Assets.IMG_TESTINSTRUMENT)));
		}
		
		public function getInventory():Vector.<InstrumentData>
		{
			return instrumentsInventory;
		}


		public function addToHexInstruments(xIndex:uint, yIndex:uint, instrument:InstrumentData):void {

			if (!hexInstruments[xIndex])          hexInstruments[xIndex]            = new Object;
			if (!hexInstruments[xIndex][yIndex])  hexInstruments[xIndex][yIndex]    = new Vector.<InstrumentData>;

			hexInstruments[xIndex][yIndex].push(instrument);
		}

		public function getHexInstruments(xIndex:uint, yIndex:uint):Vector.<InstrumentData> {

			if (!hexInstruments[xIndex])          return new Vector.<InstrumentData>;
			if (!hexInstruments[xIndex][yIndex])  return new Vector.<InstrumentData>;

			return hexInstruments[xIndex][yIndex];
		}
	}

}
