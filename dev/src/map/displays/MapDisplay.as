package map.displays 
{
	import common.displays.ControlPanel;
	import common.displays.Display;
	import common.ScrollCamera;
	import flash.events.ContextMenuEvent;
	import map.MapEntity;
	import map.MapView;
	import observatory.Node;
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
		private var controlPanel:ControlPanel;
		
		public function MapDisplay(mapView:MapView, game:Game)
		{
			super(mapView, 0, 0, FP.width, FP.height);
			
			this.game			= game;
			this.mapView		= mapView;
			scrollCamera		= new ScrollCamera(this, 350, 0, 0, WIDTH, HEIGHT);
			
			add(new MapEntity(0, 0));
			
			for (var i:int = 0 ; i < game.data.nodeList.length; i++ )
			{
				add(new NodeEntity(game.data.nodeList[i], game));
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			scrollCamera.update();
			if (Input.mousePressed && isFirstDisplayContaingMouse) handleMousePress();
		}
		
		private function maybeGetClickedNode():NodeEntity {
			
			var nodes:Vector.<NodeEntity> = new Vector.<NodeEntity>;
			getClass(NodeEntity, nodes);
			
			for each (var node:NodeEntity in nodes) {
				
				if (node.checkForMouseClick()) return node;
			}
			
			return null;
		}
		
		private function handleMousePress():void {
			
			var clickedNode:NodeEntity = maybeGetClickedNode();
			
			if (clickedNode)	mapView.controller.nodeClicked(clickedNode);
			else				mapView.controller.emptySpaceClicked(mouseX, mouseY);
		}
	}

}