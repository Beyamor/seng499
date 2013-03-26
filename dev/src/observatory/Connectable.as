package observatory
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Connectable extends ObservatoryComponent
	{
		private var connections:Vector.<ObservatoryComponent>;
		public function Connectable(d:ComponentData) 
		{
			super(d);
			connections = new Vector.<ObservatoryComponent>;
		}
		
		public function connect(component:ObservatoryComponent):void
		{
			connections.push(component);
		}
		
		public function getConnections():Vector.<ObservatoryComponent>
		{
			return connections;
		}
		
	}

}
