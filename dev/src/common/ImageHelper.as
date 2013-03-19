package common 
{
	import net.flashpunk.graphics.Image;
	/**
	 * Just, like, junk that helps us do stuff with images.
	 * @author beyamor
	 */
	public class ImageHelper 
	{
		/**
		 * Returns an image, creating a new image with the provided object if necessary.
		 */
		public static function asImage(something:*):Image {
			
			return (something is Image)? (something as Image) : (new Image(something));
		}
	}

}