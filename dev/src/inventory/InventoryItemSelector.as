package inventory 
{
	import common.ui.Button;
	import common.ui.Cursor;
	import map.MapView;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import model.GameState;
	import model.Game;
	import common.Assets;
		import net.flashpunk.World;
        import observatory.ComponentData;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InventoryItemSelector //extends Entity
	{
		private var data:ComponentData;
		private var x:int;
		private var y:int;
		public function InventoryItemSelector(x:int, y:int,data:ComponentData) 
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
								
								var mapWorld:MapView = (FP.world as MapView);
								
								mapWorld.getGame().state.setInstrumentBeingPlaced(data);
								mapWorld.setCursor(Cursor.forPlacingInstrument(data));
								
								FP.console.log("clicked "+data.getName());

							})
							.build();
		}
		
	}

}
