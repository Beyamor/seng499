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
		
		public function getName():String
		{
			return name;
		}
		
		public function getInstrument():Instrument
		{
			return(new stub(name));
		}
	}
}