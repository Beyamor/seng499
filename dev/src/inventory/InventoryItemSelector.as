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
		private var data:InstrumentData;
		private var x:int;
		private var y:int;
		public function InventoryItemSelector(x:int, y:int,data:InstrumentData) 
		{
			this.x = x;
			this.y = y;
			this.data = data
		}
		
		private function assembleGraphic():Graphiclist
		{
			var images:Graphiclist = new Graphiclist();
			//images.add() background Use coltons new graphic thing
			images.add(new Image(Assets.IMG_ITEMBACKGROUND));
			
			var img:Image = data.getImage();
			img.x = 5;
			img.y = 5;
			images.add(img);
			
			var txt:Text = data.getText();
			txt.x = 5;
			txt.y = 60;
			txt.color = 0x000000;
			images.add(txt); 
			return images;
		}
		
		public function getButton():Button 
		{
			return Button.description()
							.withGraphicList(assembleGraphic())
							.fixedAt(x, y)
							.whenClicked(function():void {
								//DO NOT REMOVE. Statements need to be fixed.
								if ((FP.world as MapView).getGame().state.isPlacing()==false)
								{
									(FP.world as MapView).getGame().state.setInstrumentBeingPlaced(data);
								}
								FP.console.log("clicked "+data.getNameString);

							})
							.build();
		}
		
	}

}
