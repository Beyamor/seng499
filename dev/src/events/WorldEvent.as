package events 
{
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
	}
	
}