package hex.entities
{
	import net.flashpunk.Entity;
	import observatory.Instrument;
	import observatory.ObservatoryComponent;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class HexInstrumentImage extends HexComponentEntity
	{
		private var instrument:Instrument;
		public function HexInstrumentImage(instrument:ObservatoryComponent, x:int, y:int) 
		{
			super(instrument, x, y);
		}
	}
}
