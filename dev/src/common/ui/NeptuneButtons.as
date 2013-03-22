package common.ui 
{
	import common.Assets;
	import common.graphics.BevelledRect;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author beyamor
	 */
	public class NeptuneButtons 
	{
		public static const MARGIN:int = 3;
		
		public static function standard(label:String, x:Number, y:Number, onClick:Function):Button {
						
			var text:Text = new Text(label);
			text.x = MARGIN;
			text.y = MARGIN;
			text.color = 0x000000;
			
			var background:BevelledRect = new BevelledRect(text.width + MARGIN * 2, text.height + MARGIN * 2, 0xF4F5EB, 0x000000, 4);
			
			return new Button(false, x, y, background.width, background.height, new Graphiclist(background, text), onClick);
		}
		
		public static function close(containerWidth:Number, containerHeight:Number, onClick:Function):Button {
			
			var closeImage:Image	= new Image(Assets.IMG_CLOSE);
			var closeButton:Button	= Button.description()
											.withImage(closeImage)
											.at(containerWidth - closeImage.width - MARGIN, 0 + MARGIN)
											.whenClicked(onClick)
											.build();
											
			return closeButton;
		}
	}

}