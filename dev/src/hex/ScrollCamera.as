package hex {

    import flash.geom.Rectangle;
    import net.flashpunk.FP;
    import net.flashpunk.utils.Input;

    /**
     *      A camera moved by the keyboard.
     */
    public class ScrollCamera {

        private var x:Number, y:Number, minX:Number, maxX:Number, minY:Number, maxY:Number;
        private var speed:Number;
    
        public function ScrollCamera(speed:Number, minX:Number, minY:Number, maxX:Number, maxY:Number) {

           x = FP.camera.x;
           y = FP.camera.y;

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

            x = FP.clamp(x, minX, maxX - FP.width);
            y = FP.clamp(y, minY, maxY - FP.height);

            FP.camera.x = x;
            FP.camera.y = y;
        }
    }
}
