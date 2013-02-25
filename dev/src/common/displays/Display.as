package common.displays {

    import flash.geom.Point;
    import flash.geom.Rectangle;
    import net.flashpunk.World;
    import flash.display.BitmapData;
    import net.flashpunk.FP;
    import net.flashpunk.Entity;

    public class Display extends World {

        private var _parent:World;
        public function get parent():World { return _parent; }

        private var _buffer:BitmapData;

        private var _width:int;
        public function get width():int { return _width; }

        private var _height:int;
        public function get height():int { return _height; }

        private var _x:int;
        private var _y:int;

        public function get x():int { return _x; }
        public function get y():int { return _y; }

        public function get center():Point { return new Point(x + width/2, y + height/2); }

        public var stack:DisplayStack = null;

        /**
         *      Whether this display prevents the ones below it from updating.
         */
        public var blocksUpdates:Boolean = false;

        public function Display(parent:World, x:int, y:int, width:int, height:int) {

            super();

            _parent     = parent;
            _x          = x;
            _y          = y;
            _width      = width;
            _height     = height;

            _buffer     = new BitmapData(width, height, true, 0);
        }

        override public function add(e:Entity):Entity {

            super.add(e);
            e.renderTarget = _buffer;
            return e;
        }

        override public function remove(e:Entity):Entity {

            e.renderTarget = null;
            return super.remove(e);
        }

        private function clearBuffer():void {

            _buffer.fillRect(_buffer.rect, 0);
        }

        override public function render():void {

            clearBuffer();

            // This is mega hack
            // So that entities render to the buffer with consideration for the display's x and y,
            // we need to offset the camera point.
            // Might be worth changing the Entity render function to account for world's camera?
            var xOffset:Number = x + camera.x;
            var yOffset:Number = y + camera.y;

            FP.camera.x += xOffset;
            FP.camera.y += yOffset;

            super.render();

            FP.camera.x -= xOffset;
            FP.camera.y -= yOffset;

            FP.buffer.copyPixels(
                _buffer,
                new Rectangle(0, 0, width, height),
                new Point(x, y));
        }

        public function get containsMouse():Boolean {

            return FP.screen.mouseX >= x &&
                   FP.screen.mouseX <= x + width &&
                   FP.screen.mouseY >= y &&
                   FP.screen.mouseY <= y + height;
        }
    }
}
