package hex.controllers 
{
	import common.ui.Cursor;
	import hex.entities.HexComponentEntity;
	import hex.HexTile;
	import hex.HexView;
	import hex.ui.ConnectionCable;
	import model.Game;
	import net.flashpunk.Entity;
	import observatory.Connectable;
	/**
	 * This guys sets the connection point for the intstrument being placed
	 * @author beyamor
	 */
	public class ConnectionStarter implements HexController 
	{
		private var game:Game;
		private var view:HexView;
		private var cable:ConnectionCable;
		
		public function ConnectionStarter(view:HexView, game:Game)
		{
			this.game = game;
			this.view = view;
			
			view.setCursor(Cursor.forPlacingInstrument(game.state.getInstrumentBeingPlaced()));
			view.instructionDisplay.show("select a node or junction box");
		}
		
		public function hexSelected(mouseX:Number, mouseY:Number, tile:HexTile):void {
			
			for each (var hitbox:HexComponentEntity in tile.hexSubEntities)
			{
				if (hitbox.component is Connectable)
				{
					if (hitbox.containsPoint(mouseX, mouseY)) {
				
						game.state.setConnectionPoint(hitbox.component as Connectable);
						
						view.controller					= new InstrumentPlacer(view, game);
						view.hexDisplay.connectionCable	= new ConnectionCable(tile.x, tile.y);
						game.state.connectionX = tile.x;
						game.state.connectionY = tile.y;
						
						view.instructionDisplay.show("place instrument on a hex");						
						return;
					}
				}
			}
			
			view.instructionDisplay.show("select a node or junction box");
		}
	}

}