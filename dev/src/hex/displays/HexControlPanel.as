package hex.displays 
{
	import common.Assets;
	import common.displays.ControlPanel;
	import common.displays.DisplayStack;
	import common.ui.Button;
	import hex.HexView;
	import hex.terrain.ui.Legend;
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
		private var widgets:DisplayStack;
		
		public function HexControlPanel(parent:HexView, game:Game) 
		{
			clearColor		= 0x88000000;
			
			super(parent);
			
			addStandardButton("Map", function():void { parent.returnToMapView(); } );
			
			widgets = new DisplayStack(
						new Legend(this));
		}
		
		override public function update():void 
		{
			super.update();
			widgets.update();
		}
		
		override protected function renderBody():void 
		{
			super.renderBody();
			widgets.render();
		}
		
	}

}