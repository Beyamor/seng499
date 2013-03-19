package time 
{
	import common.Assets;
	import events.world.SeasonalEvent;
	/**
	 * ...
	 * @author beyamor
	 */
	public class Season 
	{
		public var name:String, picture:Class, description:String;
		
		/**
		 * OH GOD DON'T CREATE SEASONS OUTSIDE OF THE SEASONS CLASS
		 * OH MAMA OH LAWDY
		 */
		public function Season(name:String, picture:Class, description:String)
		{
			this.name			= name;
			this.picture		= picture;
			this.description	= description;
		}
	}

}