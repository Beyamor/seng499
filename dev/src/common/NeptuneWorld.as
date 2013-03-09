package common 
{
	import common.ui.Cursor;
	import net.flashpunk.World;
	
	/**
	 * Stuff common to all worlds in our game.
	 * @author beyamor
	 */
	public class NeptuneWorld extends World 
	{
		private var cursor:Cursor;
		
		public function NeptuneWorld() 
		{
			
		}
		
		public function removeCursor():void {
			
			if (cursor) remove(cursor);
		}
		
		public function setCursor(newCursor:Cursor):void {
			
			if (cursor) remove(cursor);
			cursor = newCursor;
			cursor.show();
			add(cursor);
		}
		
		override public function end():void 
		{
			super.end();
			Cursor.hideActiveIfThis(cursor);
		}
	}

}