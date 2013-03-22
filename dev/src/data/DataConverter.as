package data 
{
	/**
	 * Takes data; gives money. Who doesn't like that?
	 * @author beyamor
	 */
	public class DataConverter 
	{
		public static const DATA_TO_MONEY_FACTOR:Number	= 75;
		
		private var tally:DataTally
		
		public function DataConverter(dataTally:DataTally)
		{
			tally = dataTally;
		}
		
		public function get totalValue():uint {
			
			return baseValue + bonusValue;
		}
		
		public function get baseValue():uint {
			
			return tally.baseSum * DATA_TO_MONEY_FACTOR;
		}
		
		public function get bonusValue():uint {
			
			return tally.bonusSum * DATA_TO_MONEY_FACTOR;
		}
	}

}