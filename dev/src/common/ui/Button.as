package common.ui
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
        import net.flashpunk.Graphic;
	import flash.geom.Point;

	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Button extends Entity
	{
	
		private var screenX:int;
		private var screenY:int;
		private var clickFunc:Function;
		
		public function Button(x:int, y:int, width:Number, height:Number, graphic:Graphic, clickFunc:Function) 
		{
			screenX = x;
			screenY = y;
                        this.width = width;
                        this.height = height;
                        this.graphic = graphic;
			this.clickFunc = clickFunc;
		}
		
		public function wasClicked():Boolean
		{
			if (Input.mousePressed)
			{
				if ( Input.mouseX >= screenX && Input.mouseX <= screenX + width)
				{
					if (Input.mouseY >= screenY && Input.mouseY <= screenY + height)
					{
						return true;
					}
				}
			}
			return false;
		}
		
		private function onClick():void
		{
			clickFunc();
		}
		
		public override function update():void
		{
			if (wasClicked())
			{
				onClick();
			}
		}

                /**
                 *      Overridden to always draw screen-relative
                 */
                public override function render():void {

                        // Draw without camera offset.
                        var cameraPoint:Point   = new Point(0, 0);

                        // The draw point is screen-relative
                        var drawPoint:Point = new Point(0, 0);

			if (graphic && graphic.visible)
			{
				if (graphic.relative)
				{
					drawPoint.x = screenX;
					drawPoint.y = screenY;
				}

				graphic.render(renderTarget ? renderTarget : FP.buffer, drawPoint, cameraPoint);
			}
                }
		
            /**
             *      Creates a new fluent button builder.
             /*/
            public static function description():ButtonBuilder {

                return new ButtonBuilder();
            }
	}
}
