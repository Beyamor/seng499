package common.displays {

    import flash.geom.Point;
    import flash.geom.Rectangle;
    import net.flashpunk.World;
    import flash.display.BitmapData;
    import net.flashpunk.FP;
    import net.flashpunk.Entity;

    /**
     *      A display is kind of like a sub-world or a windowed view, I guess?
     *      It has its own entities and it renders only to a portion of the screen.
     *      If you have different "groupings" of entities (e.g. background, nav buttons, and overlay),
     *      you probably want to stick them in different displays.
     *
     *      You can have multiple displays side by side or even on top of each other.
     *
     *      Create the display with an x and y specifying its top-left in its parent world
     *      as well the width and height of its view.
     *
     *      Coordinates in the display are relative to its x and y position.
     *      So, if you place an entity at (0,0) in the display,
     *      that entity will show up at (x,y) in the parent world.
     *      Makes sense?
     *
     *      Rather than moving FP.camera,
     *      always move the display's camera to change what the display is rendering.
     *
     */
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

        public function get center():Point { return new Point(width/2, height/2); }

        public var stack:DisplayStack = null;

        /**
         *      Whether this display prevents the ones below it from updating.
         */
        public var blocksUpdates:Boolean = false;

        /**
         *      The color used to fill the buffer on redraw
         *      Note: alpha must be specified. 0x000000 is transparent black. 0xff000000 is opaque black.
         */
         public var clearColor:uint = 0x00000000;

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

            _buffer.fillRect(_buffer.rect, clearColor);
        }

        override public function render():void {

            clearBuffer();

            // This is mega hack
            // So that entities render to the buffer with consideration for the display's x and y,
            // we need to offset the camera point.
            // Might be worth changing the Entity render function to account for world's camera?
            var xOffset:Number = camera.x;
            var yOffset:Number = camera.y;

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

	/**
	 * X position of the mouse in the World.
	 */
	override public function get mouseX():int
	{
		return FP.screen.mouseX + FP.camera.x - x;
	}
	
	/**
	 * Y position of the mouse in the world.
	 */
	override public function get mouseY():int
	{
		return FP.screen.mouseY + FP.camera.y - y;
	}

    }
}
