package model 
{
	import common.Assets;
	import net.flashpunk.graphics.Image;
	import map.Node;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class PlayerData 
	{

		public var instrumentsInventory:Vector.<InstrumentData> = new Vector.<InstrumentData>();
		public var storeList:Vector.<InstrumentData> = new Vector.<InstrumentData>();
		public var nodeList:Vector.<Node> = new Vector.<Node>();
		private var nextId:uint = 0; //This will need to be treaated differently when loading a saved game.
        private var hexInstruments:Object = new Object;
		
		
		public function PlayerData()
		{
			populateStoreList();
			addDummyData();
		}
		
		public function printInventory():void
		{
			trace("begin");
			for (var i:int; i < instrumentsInventory.length; i++ )
			{
				trace((instrumentsInventory[i]as Instrument).getName());
			}
			trace("end");
		}
		
		public function addToInventory(data:InstrumentData):void
		{
			instrumentsInventory.push(data);
		}
		
		public function populateStoreList():void
		{
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
		}
		
		public function addDummyData():void
		{
			addToInventory(new InstrumentData(0));
			instrumentsInventory.push(new InstrumentData(1));
		}
		
		public function getInventory():Vector.<InstrumentData>
		{
			return instrumentsInventory;
		}
		
		public function getNextId():uint {
			return nextId++;
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
