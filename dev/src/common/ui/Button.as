package common.ui
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
    import net.flashpunk.Graphic;

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
			this.x = FP.camera.x + screenX;
			this.y = FP.camera.y + screenY;
                        this.width = width;
                        this.height = height;
                        this.graphic = graphic;
			this.clickFunc = clickFunc;
		}
		
		public function wasClicked():Boolean
		{
			if (Input.mousePressed)
			{
                                var worldMouseX:Number = Input.mouseX + FP.camera.x,
                                    worldMouseY:Number = Input.mouseY + FP.camera.y;

				if ( worldMouseX >= x && worldMouseX <= x + width)//uses world coordinates
				{
					if ( worldMouseY >= y && worldMouseY <= y + height)//uses world coordinates
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
			x = FP.camera.x + screenX;
			y = FP.camera.y + screenY;
			
			if (wasClicked())
			{
				onClick();
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
