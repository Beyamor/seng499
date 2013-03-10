package common {

	import common.displays.Display;
    import flash.geom.Rectangle;
    import net.flashpunk.FP;
    import net.flashpunk.utils.Input;

    /**
     *      A camera moved by the keyboard.
     */
    public class ScrollCamera {

        private var x:Number, y:Number, minX:Number, maxX:Number, minY:Number, maxY:Number;
        private var speed:Number;
		private var display:Display;
    
        public function ScrollCamera(display:Display, speed:Number, minX:Number, minY:Number, maxX:Number, maxY:Number) {

			this.display = display;
			x = display.camera.x;
			y = display.camera.y;

			this.minX = minX;
			this.minY = minY;
			this.maxX = maxX;
			this.maxY = maxY;

			this.speed = speed;
        }

        public function update():void {

            var dx:Number = 0, dy:Number = 0;

            if (Input.check("hex-scroll-up"))		dy -= 1;
            if (Input.check("hex-scroll-down"))		dy += 1;
            if (Input.check("hex-scroll-left"))		dx -= 1;
            if (Input.check("hex-scroll-right"))	dx += 1;

            if (dx != 0 && dy != 0) {

                dx *= Math.SQRT1_2;
                dy *= Math.SQRT1_2;
            }

            x += dx * speed * FP.elapsed;
            y += dy * speed * FP.elapsed;

            x = FP.clamp(x, minX, maxX - display.width);
            y = FP.clamp(y, minY, maxY - display.height);

            display.camera.x = x;
            display.camera.y = y;
        }
    }
}
