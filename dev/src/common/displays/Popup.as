package common.displays 
{
	import common.Assets;
	import common.ui.Button;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author beyamor
	 */
	public class Popup extends Display 
	{
		
		public function Popup(parent:World, width:uint, height:uint)
		{
			// Just going to assume the popup should be centered
			super(
				parent,
				FP.halfWidth - width / 2,
				FP.halfHeight - height / 2,
				width,
				height);
				
			addCloseButton();
		}
		
		public function close():void {
			
			// Just gunna assume this is the top of the stack
			if (stack && stack.top == this) stack.pop();
		}
		
		private function addCloseButton():void {
			
			const magicButtonBorder:int = 2;
			
			var closeImage:Image	= new Image(Assets.IMG_CLOSE);
			var closeButton:Button	= Button.description()
											.withImage(closeImage)
											.at(width - closeImage.width - magicButtonBorder, magicButtonBorder)
											.whenClicked(function():void { close(); } )
											.build();
			add(closeButton);
		}
	}

}