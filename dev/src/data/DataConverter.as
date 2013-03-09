package data 
{
	/**
	 * Takes data; gives money. Who doesn't like that?
	 * @author beyamor
	 */
	public class DataConverter 
	{
		public static const DATA_TO_MONEY_FACTOR:Number	= 100;
		
		private var dataSum:uint;
		
		public function DataConverter(dataSum:uint)
		{
			this.dataSum = dataSum;
		}
		
		public function get moneyValue():uint {
			
			return dataSum * DATA_TO_MONEY_FACTOR;
		}
	}

}