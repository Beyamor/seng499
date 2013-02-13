package  
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class PlayerData 
	{
		private var instrumentsInventory:Vector.<InstrumentStub> = new Vector.<InstrumentStub>();
		private var storeList:Vector.<InstrumentStub> = new Vector.<InstrumentStub>();
		
		public function printInventory()
		{
			trace("begin");
			for (var i:int; i < instrumentsInventory.length; i++ )
			{
				trace((instrumentsInventory[i]as Instrument).get_name());
			}
			trace("end");
		}
		
		public function addToInventory(stub:InstrumentStub)
		{
			instrumentsInventory.push(stub);
		}
		
		public function populateStoreList()
		{
			storeList.push(new InstrumentStub("A"));
			storeList.push(new InstrumentStub("B"));
		}
		
		public function getInventory()
		{
			return instrumentsInventory;
		}
	}

}