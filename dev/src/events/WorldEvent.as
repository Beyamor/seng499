package events 
{
	import common.displays.Display;
	import model.Game;
	
	/**
	 * I dunno what to call this, man.
	 * Events that, y'know, occur in the world.
	 * @author beyamor
	 */
	public interface WorldEvent 
	{
		function hasOccurred(game:Game):Boolean;
		function wasAchieved(game:Game):Boolean;
		function giveRewards(game:Game):void;
		
		// Dunno how amazing I feel putting these in here, but whatever.
		// It's this or some overly complicated dispatch mechanism.
		function get announcementDisplay():Display;
		function get achievementDisplay():Display;
		function get failureDisplay():Display;
	}
	
}