package common.ui 
{
	import flash.ui.Mouse;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	/**
	 * Custom mouse cursor.
	 * PLEASE NOTE: If a world is using a custom cursor, it is responsible for calling Cursor.hideActive on end
	 * @author beyamor
	 */
	public class Cursor extends Entity 
	{
		private static var activeCursor:Cursor = null;
		
		public function Cursor(graphic:Graphic)
		{
			this.graphic = graphic;
			layer = -9999999; // sucky hacky suck suck
		}
		
		public function show():Cursor {
			
			if (activeCursor) activeCursor.hide();
			activeCursor = this;
			Mouse.hide();
			visible = true;
			
			return this;
		}
		
		public function hide():Cursor {
			
			if (activeCursor == this) {
				
				activeCursor = null;
				Mouse.show();
			}
			
			visible = false;
			
			return this;
		}
		
		override public function update():void 
		{
			super.update();
			
			x = world.mouseX;
			y = world.mouseY;
		}
		
		public static function fromImage(source:*):Cursor {
			
			return new Cursor(new Image(source));
		}
		
		public static function hideActive():void {
			
			if (!activeCursor) return;
			
			activeCursor.hide();
		}
	}

}