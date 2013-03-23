package common.ui
{
	import common.Assets;
	import common.displays.Display;
	import flash.media.Sound;
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
		private var enabled:Boolean = true;
		private function get worldIsDisplay():Boolean { return world && world is Display }
		private function get worldAsDisplay():Display { return world as Display; }

		// Making this public so that you can toggle it externally if needed.
		public var isFixed:Boolean;
		
		public function Button(isFixedToScreen:Boolean, x:int, y:int, width:Number, height:Number, graphic:Graphic, clickFunc:Function) 
		{
			isFixed = isFixedToScreen;

			if (isFixed) {

				screenX = x;
				screenY = y;
			}

			else {

				this.x = x;
				this.y = y;
			}

			this.width = width;
			this.height = height;
			this.graphic = graphic;
			this.clickFunc = clickFunc;
		}
		
		public function wasClicked():Boolean
		{
			
			
			if (worldIsDisplay && !worldAsDisplay.containsMouse) return false;
			
			if (Input.mousePressed)
			{
				if ( world.mouseX >= x && world.mouseX <= x + width)
				{
					if (world.mouseY >= y && world.mouseY <= y + height)
					{
						// you dont gatta ask me to fixdis!- CP
						var chinceAsset:Class = FP.choose(Assets.SOUND_ONTOUCH, Assets.SOUND_ONTOUCH2, Assets.SOUND_ONTOUCH3); 
						var chinceSound:Sound = (new chinceAsset) as Sound;
						chinceSound.play();
						
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
			if (isFixed) {

				x = FP.camera.x + world.camera.x + screenX;
				y = FP.camera.y + world.camera.y + screenY;
			}

			if (!enabled) return;

			if (wasClicked())
			{
				onClick();
			}
		}

		/**
		 *      Overridden to always draw screen-relative
		 */
		public override function render():void {

			// To make sure the position is always camera-relative if the button is fixed to the screen,
			// we're going to update the position here.
			// The risk of updating the position in the update method is that the position gets updated,
			// *then* the camera moves.
			if (isFixed) {

				// Draw without camera offset
				var cameraPoint:Point = new Point(0, 0);

				// The draw point is screen-relative
				var drawPoint:Point = new Point(0, 0);

				if (graphic && graphic.visible) {

					drawPoint.x = screenX;
					drawPoint.y = screenY;
				}

				graphic.render(renderTarget? renderTarget : FP.buffer, drawPoint, cameraPoint);
			}

			else {

				super.render();
			}
		}

                public function enable():void   { enabled = true; }
                public function disable():void  { enabled = false; }
		
		/**
		 *      Creates a new fluent button builder.
		 /*/
		public static function description():ButtonBuilder {

			return new ButtonBuilder();
		}
	}
}
