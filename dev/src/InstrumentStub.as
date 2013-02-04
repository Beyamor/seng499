package  
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InstrumentStub 
	{
		private var name:String;
		private var stub:Class = Instrument;
		
		public function InstrumentStub() 
		{
			this.name = name;
		}
		
		public function get_name():String
		{
			return name;
		}
		
		public function get_instrument():Instrument
		{
			return(new stub(name));
		}
	}
}