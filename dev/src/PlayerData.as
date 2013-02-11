package  
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class PlayerData 
	{
		private var instruments_inventory:Array = new Array();
		private var store_list:Array = new Array();
		
		public function print_inventory()
		{
			trace("begin");
			for (var i:int; i < instruments_inventory.length; i++ )
			{
				trace((instruments_inventory[i]as Instrument).get_name());
			}
			trace("end");
		}
		
		public function add_to_inventory(stub:InstrumentStub)
		{
			instruments_inventoy.push(stub);
		}
		
		public function populate_store_list()
		{
			store_list.push(new InstrumentStub("A"));
			store_list.push(new InstrumentStub("B"));
		}
	}

}