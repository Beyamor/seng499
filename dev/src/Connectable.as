package  
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Connectable extends ObservatoryComponent
	{
		private var connections:Vector.<ObservatoryComponent>;
		public function Connectable() 
		{
			connections = new Vector.<ObservatoryComponent>;
		}
		
		public function connect(component:ObservatoryComponent):void
		{
			connections.push(component);
		}
		
	}

}