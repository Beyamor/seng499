package common 
{
	/**
	 * ...
	 * @author beyamor
	 */
	public class Collections 
	{
		public static function any(coll:*):* {
			
			var randomIndex:uint = Math.floor(Math.random() * coll.length);
			return coll[randomIndex];
		}
	}

}