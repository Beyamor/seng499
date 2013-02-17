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
		
		public function addToInventory(instrumentData:InstrumentData)
		{
			instrumentsInventory.push(instrumentData);
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
	}

}