package inventory 
{
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InventoryItemSelector 
	{
		private var stub:InstrumentStub;
		public function InventoryItemSelector(x:int, y:int,stub:InstrumentStub) 
		{
			this.stub = stub;
			var images:Graphiclist = new Graphiclist();
			//images.add() background Use coltons new graphic thing
			//add instrument image
			images.add(new Text(stub.getName())); //add instrument name text
		}
	}

}