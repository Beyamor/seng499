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

        public var width:int;
        public var height:int;
        public var x:int;
        public var y:int;
		
		private var rightEdgePin:* = null;

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
			this.x          = x;
			this.y          = y;
			this.width      = width;
			this.height     = height;

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
		
		override public function update():void 
		{
			super.update();
			
			if (rightEdgePin) width = rightEdgePin.x - x;
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
		
		public function containsPoint(someX:Number, someY:Number):Boolean {
			
			return	x <= someX &&
					y <= someY &&
					x + width >= someX &&
					y + height >= someY;
		}

		public function get containsMouse():Boolean {

			return containsPoint(FP.screen.mouseX, FP.screen.mouseY);
		}
		
		

		/**
		 * X position of the mouse in the World.
		 */
		override public function get mouseX():int
		{
			return FP.screen.mouseX + FP.camera.x - x + camera.x;
		}
		
		/**
		 * Y position of the mouse in the world.
		 */
		override public function get mouseY():int
		{
			return FP.screen.mouseY + FP.camera.y - y + camera.y;
		}
	
		public function get isFirstDisplayContaingMouse():Boolean {
			
			if (!containsMouse) return false;
			if (!stack) return true;
			
			return stack.isFirstDisplayContainingPoint(this, FP.screen.mouseX, FP.screen.mouseY);
		}

		public function expandRightEdgeTo(something:*):void { rightEdgePin = something; }
		public function withRightEdgeExpandingTo(something:*):Display { expandRightEdgeTo(something); return this; }
    }
}
