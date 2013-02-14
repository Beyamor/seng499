package inventory 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import common.Assets;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InventoryItemSelector extends Entity
	{
		private var stub:InstrumentStub;
		public function InventoryItemSelector(x:int, y:int,stub:InstrumentStub) 
		{
			super(x, y);
			this.stub = stub;
			var images:Graphiclist = new Graphiclist();
			//images.add() background Use coltons new graphic thing
			images.add(new Image(Assets.IMG_ITEMBACKGROUND));
			images.add(stub.getImageAt(5,5));
			images.add(stub.getTextAt(5, 60)); //add instrument name text
			graphic = images;
		}
	}

}