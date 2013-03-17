package common.graphics 
{
	import common.ui.Button;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	import net.flashpunk.Graphic;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class BevelledRect extends Graphic 
	{
		private static const LINE_WIDTH:Number = 1;
		
		private var _buffer:BitmapData;
		public var width:Number;
		public var height:Number;
		
		public function BevelledRect(width:Number, height:Number, color:uint, outlineColor:uint=0x000000, bevel:uint=3)
		{
			this.width	= width;
			this.height	= height;
			_buffer		= new BitmapData(width, height, true, 0);
			
			renderToBuffer(color, outlineColor, bevel);
		}
		
		private function renderToBuffer(color:uint, outlineColor:uint, bevel:uint):void {
			
			var shape:Shape         = new Shape;
            var graphics:Graphics   = shape.graphics;

            graphics.clear();
			
			graphics.lineStyle(LINE_WIDTH, 0x000000, 1);
			graphics.beginFill(color, 1);
			graphics.drawRoundRect(LINE_WIDTH / 2, LINE_WIDTH / 2, width - LINE_WIDTH, height - LINE_WIDTH, bevel * 2, bevel * 2);
			graphics.endFill();
			
			_buffer.draw(shape);
		}
		
		override public function render(target:BitmapData, point:Point, camera:Point):void {
            
            // determine drawing location
            _point.x = point.x + x - camera.x * scrollX;
            _point.y = point.y + y - camera.y * scrollY;
            
            // render without transformation
            target.copyPixels(_buffer, _buffer.rect, _point, null, null, true);
        }
	}

}