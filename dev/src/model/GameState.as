package model 
{
        import hex.controllers.HexController;
        import hex.controllers.TileViewer;

	/**
	 * ...
	 * @author Lambwatt
	 */
	public class GameState 
	{
		
		public function GameState() 
		{
			
		}

                /**
                 *      Return's the hex view's controller.
                 *      It's definitely better to make this external
                 *      (something in the hex package that reads and acts on the game state)
                 *      But for the time being, it's simple enough to cram it in here.
                 */
                public function get hexController():HexController {

                    // So, I mean, we're either navigating or placing an item
                    // The mechanics should change as the game state is actually implemented
                    // But this interface is what the HexView will be dependent upon.
                    return new TileViewer;
                }
		
	}

}
