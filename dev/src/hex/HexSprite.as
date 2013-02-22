package hex {

    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import net.flashpunk.Graphic;
    import net.flashpunk.FP;

    public class HexSprite extends Graphic {

        private var _buffer:BitmapData;
        private var _bufferRect:Rectangle;
        private var _bitmap:Bitmap          = new Bitmap;
        private var _radius:Number;
        private var _color:uint;

        public function HexSprite(radius:Number, color:Number) {

            _radius = radius;
            _color = color;

            // Center the hexagon
            x = -radius;
            y = -radius;

            createBuffer();
            renderToBuffer();
        }

        private function createBuffer():void {

            _buffer             = new BitmapData(2 * _radius, 2 * _radius, true, 0);
            _bufferRect         = _buffer.rect;
            _bitmap.bitmapData  = _buffer;
        }

        private function renderToBuffer():void {

            var shape:Shape         = new Shape;
            var graphics:Graphics   = shape.graphics;

            graphics.clear();
            graphics.beginFill(_color);
            graphics.drawCircle(_radius, _radius, _radius);
            graphics.endFill();

            _buffer.draw(shape);
        }
       
        override public function render(target:BitmapData, point:Point, camera:Point):void {

            var firstPoint:Point;
            var secondPoint:Point;
            var pointIndex:uint;

            // Comment in for hex lines
            // for (pointIndex = 0; pointIndex < vertices.length; ++pointIndex) {

            // 	firstPoint = vertices[pointIndex];
            // 	secondPoint = vertices[(pointIndex + 1) % vertices.length];

            // 	Draw.linePlus(firstPoint.x, firstPoint.y, secondPoint.x, secondPoint.y, 0xffffff, 1, 2);
            // }

            
            // determine drawing location
            _point.x = point.x + x - camera.x * scrollX;
            _point.y = point.y + y - camera.y * scrollY;
            
            // render without transformation
            target.copyPixels(_buffer, _bufferRect, _point, null, null, true);
        }
    }
}
