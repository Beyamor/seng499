package model 
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class Game 
	{
		public var state:GameState = new GameState();
		public var data:PlayerData = new PlayerData();
		public function Game() 
		{
			state = new GameState();
			data = new PlayerData();
		}
		
	}

}