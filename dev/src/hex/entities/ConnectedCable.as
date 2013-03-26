package hex.entities 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import flash.display.Graphics;
	import flash.display.Shape;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.graphics.Stamp;
	import common.Assets;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class ConnectedCable extends Entity 
	{
		private var rootX:int = 0;
		private var rootY:int = 0;
		
		public function ConnectedCable(x:int,y:int,rootX:int,rootY:int) 
		{
			super(x, y);
			this.rootX = rootX;
			this.rootY = rootY;
			
			/*var bitmap:BitmapData = new BitmapData(Math.abs(x1 - x2), Math.abs(y1 - y2), true, 0);
			Draw.setTarget(bitmap);
			
			Draw.line(x1, y1, x2, y2, 0xFF00FF);
			
			graphic = new Stamp(bitmap);*/
			layer = 2;
			//FP.world.addGraphic(new Stamp(bitmap),-1);
		}
		
		override public function render():void 
		{
			super.render();
			
			// Temporary. Throw splines in whenever.
			var line:Shape			= new Shape();
			var graphics:Graphics	= line.graphics;
			
			graphics.lineStyle(2);			
			graphics.moveTo(x - world.camera.x, y - world.camera.y);
			graphics.lineTo(rootX - world.camera.x, rootY - world.camera.y);
			
			
			(renderTarget ? renderTarget : FP.buffer).draw(line);
		}
		
		
		
	}

}