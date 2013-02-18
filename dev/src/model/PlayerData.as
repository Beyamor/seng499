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
		public var instrumentsInventory:Vector.<InstrumentStub> = new Vector.<InstrumentStub>();
		public var storeList:Vector.<InstrumentStub> = new Vector.<InstrumentStub>();
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
		
		public function addToInventory(stub:InstrumentStub)
		{
			instrumentsInventory.push(stub);
		}
		
		public function populateStoreList():void
		{
			storeList.push(new InstrumentStub("A", new Image(Assets.IMG_TESTINSTRUMENT)));
			storeList.push(new InstrumentStub("B", new Image(Assets.IMG_TESTINSTRUMENT)));
		}
		
		public function addDummyData():void
		{
			addToInventory(new InstrumentStub("A", new Image(Assets.IMG_TESTINSTRUMENT)));
			instrumentsInventory.push(new InstrumentStub("B", new Image(Assets.IMG_TESTINSTRUMENT)));
		}
		
		public function getInventory():Vector.<InstrumentStub>
		{
			return instrumentsInventory;
		}


                public function addToHexInstruments(xIndex:uint, yIndex:uint, instrument:InstrumentStub):void {

                    if (!hexInstruments[xIndex])          hexInstruments[xIndex]            = new Object;
                    if (!hexInstruments[xIndex][yIndex])  hexInstruments[xIndex][yIndex]    = new Vector.<InstrumentStub>;

                    hexInstruments[xIndex][yIndex].push(instrument);
                }

                public function getHexInstruments(xIndex:uint, yIndex:uint):Vector.<InstrumentStub> {

                    if (!hexInstruments[xIndex])          return new Vector.<InstrumentStub>;
                    if (!hexInstruments[xIndex][yIndex])  return new Vector.<InstrumentStub>;

                    return hexInstruments[xIndex][yIndex];
                }
	}

}
