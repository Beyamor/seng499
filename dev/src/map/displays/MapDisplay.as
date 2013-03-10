package map.displays 
{
	import common.displays.Display;
	import common.ScrollCamera;
	import map.MapEntity;
	import map.MapView;
	import map.Node;
	import map.NodeEntity;
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class MapDisplay extends Display 
	{
		private static const WIDTH:int = 1440;
		private static const HEIGHT:int = 640;
		
		private var scrollCamera:ScrollCamera;
		private var game:Game;
		private var mapView:MapView;
		
		public function MapDisplay(mapView:MapView, game:Game)
		{
			super(mapView, 0, 0, WIDTH, HEIGHT);
			
			this.game		= game;
			this.mapView	= mapView;
			scrollCamera	= new ScrollCamera(this, 350, 0, 0, WIDTH, HEIGHT);
			
			add(new MapEntity(0, 0));
			
			for (var i:int = 0 ; i < game.data.nodeList.length; i++ )
			{
				add(new NodeEntity(game.data.nodeList[i]));
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			scrollCamera.update();
			
			if (game.state.isPlacing())
			{
				// We currently have a bug where, if a node has been selected for placement,
				// if the player clicks on an existing node, they will still be taken to the hex view.
				// However, the logic below will have already added the node at the map level
				// The visible symptom of the bug is a null pointer in the hex view when clicking on a tile.
				// This is because the hex controller thinks that there's still an instrument to be placed,
				// even though the logic below has already stopped instrument placement.
				// We could add a check in the hex controller, but the heart of the problem is
				// going to the hex view at all when placing a node.
				// TODO: Figure this out, dawgs.
				if (game.state.getInstrumentBeingPlaced().isNode())
				{
					if (Input.mousePressed && isFirstDisplayContaingMouse)
					{
						game.data.addNode(new Node(mouseX, mouseY));
						game.state.stopPlacingInstrument();
						mapView.removeCursor();
						add(new NodeEntity(game.data.nodeList[game.data.nodeList.length - 1]));
						//FP.console.log("Added a node.  Do you see it?");
					}
				}
			}
			
			FP.log("depr derp derp");
		}
	}

}