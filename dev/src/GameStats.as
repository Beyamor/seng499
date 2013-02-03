package  
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class GameStats 
	{
		private var instruments_inventoy:Array;
		
		public function GameStats() 
		{
			instruments_inventoy = new Array();
		}
		
		public function print_inventory()
		{
			trace("begin");
			for (var i:int; i < instruments_inventoy.length; i++ )
			{
				trace((instruments_inventoy[i]as Instrament).get_name());
			}
			trace("end");
		}
		
	}

}