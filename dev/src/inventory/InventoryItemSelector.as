package inventory 
{
	import common.ui.Button;
	import map.MapView;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import model.GameState;
	import model.Game;
	import common.Assets;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InventoryItemSelector //extends Entity
	{
		private var stub:InstrumentStub;
		private var x:int;
		private var y:int;
		public function InventoryItemSelector(x:int, y:int,stub:InstrumentStub) 
		{
			//super(x, y);
			this.x = x;
			this.y = y;
			this.stub = stub;
			//var images:Graphiclist = new Graphiclist();
			/*/images.add() background Use coltons new graphic thing
			/images.add(new Image(Assets.IMG_ITEMBACKGROUND));
			images.add(stub.getImageAt(5,5));
			images.add(stub.getTextAt(5, 60)); //add instrument name text
			graphic = images;
			
			setHitbox(images[0].width, images[0].height);
			*/
		}
		
		private function assembleGraphic():Graphiclist
		{
			var images:Graphiclist = new Graphiclist();
			//images.add() background Use coltons new graphic thing
			images.add(new Image(Assets.IMG_ITEMBACKGROUND));
			images.add(stub.getImageAt(5,5));
			images.add(stub.getTextAt(5, 60)); //add instrument name text
			return images;
		}
		
		public function getButton():Button 
		{
			return Button.description()
							.withGraphicList(assembleGraphic())
							.at(x, y)
							.whenClicked(function():void {
								//DO NOT REMOVE. Statements need to be fixed.
								/*if ((((FP.world as MapView).getGame as Game).state as GameState).getPlacing==false)
								{
									(((FP.world as MapView).getGame as Game).state as GameState).setInstrumentBeingPlaced(stub);
								}*/
								FP.console.log("clicked "+stub.getNameString);
							})
							.build();
		}
		
	}

}