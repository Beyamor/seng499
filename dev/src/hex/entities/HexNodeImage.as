package hex.entities 
{
	import net.flashpunk.Entity;
	import observatory.ObservatoryComponent;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class HexNodeImage extends HexComponentEntity 
	{
		
		public function HexNodeImage(instrument:ObservatoryComponent,x:int,y:int) 
		{
			super(instrument, x, y);
		}
	}
}