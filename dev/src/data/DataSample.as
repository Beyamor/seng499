package data 
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class DataSample 
	{
		public var media:Class;
		public var description:String;
		public var isVideo:Boolean;
		public function DataSample(media:Class, isVideo:Boolean,description:String) 
		{
			this.media = media;
			this.description = description;
			this.isVideo = isVideo;
		}
		
	}
}