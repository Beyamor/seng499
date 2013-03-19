package common.displays {

	import common.PositionHelper;
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

        private var _buffer:BitmapData;

        public var width:int;
        public var height:int;
        public var x:int;
        public var y:int;
		
		public function get halfWidth():Number { return width / 2; }
		public function get halfHeight():Number { return height / 2; }
		
		private var rightEdgePin:* = null;

        public function get center():Point { return new Point(width/2, height/2); }

        public var stack:DisplayStack = null;
		
		private var onEndCallbacks:Vector.<Function> = new Vector.<Function>;
				
		// Display nesting stuff
		private var _parent:World;
        public function get parent():World { return _parent; }
        public function set parent(newParent:World):void { _parent = newParent; }
		
		private function get parentIsDisplay():Boolean { return parent is Display; }
		private function get parentAsDisplay():Display { return parent as Display; }
		
		private function get parentBuffer():BitmapData { return parentIsDisplay? parentAsDisplay._buffer : FP.buffer; }
		public function get parentWidth():int { return parentIsDisplay? parentAsDisplay.width : FP.width; }
		public function get parentHeight():int { return parentIsDisplay? parentAsDisplay.height : FP.height; }
		public function get parentHalfWidth():Number { return parentIsDisplay? parentAsDisplay.halfWidth : FP.halfWidth; }
		public function get parentHalfHeight():Number { return parentIsDisplay? parentAsDisplay.halfHeight : FP.halfHeight; }
		public function get parentX():Number { return parentIsDisplay? parentAsDisplay.x : 0 }
		public function get parentY():Number { return parentIsDisplay? parentAsDisplay.y : 0 }

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

			renderBody();

			parentBuffer.copyPixels(
				_buffer,
				new Rectangle(0, 0, width, height),
				new Point(x, y));
		}
		
		/**
		 * Render the entities in this display
		 */
		protected function renderEntities():void {
			
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
		}
		
		/**
		 * Actually renders whatever. Done after offsetting the camera and before copying pixels.
		 */
		protected function renderBody():void {
			
			renderEntities();
		}
		
		public function containsPoint(someX:Number, someY:Number):Boolean {
			
			return	parentX + x <= someX &&
					parentY + y <= someY &&
					parentX + x + width >= someX &&
					parentY + y + height >= someY;
		}

		public function get containsMouse():Boolean {

			return containsPoint(FP.screen.mouseX, FP.screen.mouseY);
		}

		/**
		 * X position of the mouse in the World.
		 */
		override public function get mouseX():int
		{
			// TODO: Should FP.camera be included in this? Whatever
			return FP.screen.mouseX - parentX - x + camera.x;
		}
		
		/**
		 * Y position of the mouse in the world.
		 */
		override public function get mouseY():int
		{
			return FP.screen.mouseY - parentY - y + camera.y;
		}
	
		public function get isFirstDisplayContaingMouse():Boolean {
			
			if (!containsMouse) return false;
			if (parentIsDisplay && !parentAsDisplay.isFirstDisplayContaingMouse) return false;
			if (!stack) return true;
			
			return stack.isFirstDisplayContainingPoint(this, FP.screen.mouseX, FP.screen.mouseY);
		}

		public function expandRightEdgeTo(something:*):void { rightEdgePin = something; }
		public function withRightEdgeExpandingTo(something:*):Display { expandRightEdgeTo(something); return this; }
		
		public function centerOnParent():void {
			
			if (parentIsDisplay)	PositionHelper.centerOn(this, parentAsDisplay);
			else					PositionHelper.centerOn(this, FP);
		}
		
		public function addOnEndCallback(callback:Function):Display {
			
			onEndCallbacks.push(callback);
			return this;
		}
		
		override public function end():void 
		{
			super.end();
			
			for each (var callback:Function in onEndCallbacks) callback();
		}
    }
}
