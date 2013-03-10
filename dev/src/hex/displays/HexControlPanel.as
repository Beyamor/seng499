package hex.displays 
{
	import common.Assets;
	import common.displays.ControlPanel;
	import common.ui.Button;
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
		public function HexControlPanel(parent:World, game:Game) 
		{
			super(parent);
			
			add(Button.description()
			.fixedAt(50, 30)
			.withDepth(-1)
			.withImage(new Image(Assets.IMG_MAP_FROM_HEX_BUTTON))
			.whenClicked(function():void {

				FP.world = new MapView(game);
			})
			.build());
		}
		
	}

}