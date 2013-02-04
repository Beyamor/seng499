package  
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InstrumentStub 
	{
		private var name:String;
		private var stub:Class;
		public function InstrumentStub() 
		{
			this.name = name;
			stub = Instrument;
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