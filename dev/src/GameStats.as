package  
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class GameStats 
	{
		private var instruments_inventoy:Array = new Array();
		private var store_list:Array = new Array();
		
		public function print_inventory()
		{
			trace("begin");
			for (var i:int; i < instruments_inventoy.length; i++ )
			{
				trace((instruments_inventoy[i]as Instrament).get_name());
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