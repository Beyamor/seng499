package hex.displays 
{
	import common.Assets;
	import common.displays.ControlPanel;
	import common.ui.Button;
	import hex.HexView;
	import map.MapView;
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexControlPanel extends ControlPanel 
	{		
		public function HexControlPanel(parent:HexView, game:Game) 
		{
			super(parent);
			
			addStandardButton("Map", function():void { parent.returnToMapView(); } );
		}
		
	}

}