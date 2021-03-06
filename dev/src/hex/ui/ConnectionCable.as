package hex.ui 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import hex.entities.ConnectedCable;
	import hex.HexView;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	
	
	/**
	 * The cable rendered when connecting a new instrument.
	 * @author beyamor
	 */
	public class ConnectionCable extends Entity 
	{
		private var line:Shape
		public function ConnectionCable(x:Number, y:Number)
		{
			super(x, y);
			layer = 2;
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		override public function render():void 
		{
			super.render();
			
			// Temporary. Throw splines in whenever.
			line			= new Shape();
			var graphics:Graphics	= line.graphics;
			
			graphics.lineStyle(2);			
			graphics.moveTo(x - world.camera.x, y - world.camera.y);
			graphics.lineTo(world.mouseX - world.camera.x, world.mouseY - world.camera.y);
			
			
			(renderTarget ? renderTarget : FP.buffer).draw(line);
		}
		
	}

}