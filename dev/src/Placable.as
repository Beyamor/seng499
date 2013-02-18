package  
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Placable extends Entity
	{
		public var id:int;
		public function Placable(x:int, y:int, id:int ) 
		{
			super(x, y);
			this.id = id;
		}
		
	}

}