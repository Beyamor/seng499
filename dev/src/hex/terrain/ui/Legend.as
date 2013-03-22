package hex.terrain.ui 
{
	import common.displays.Display;
	import flash.geom.Rectangle;
	import hex.terrain.Tables;
	import hex.terrain.Types;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Text;
	
	/**
	 * A display widget for showing the hex terrain legend
	 * @author beyamor
	 */
	public class Legend extends Display 
	{
		public static const WIDTH:int					= 170 + 20;
		public static const HEIGHT:int					= 170 + 50;
		public static const TERRAIN_SYMBOL_WIDTH:int	= 20;
		
		public function Legend(parent:Display)
		{
			super(parent, (parent.width - WIDTH) / 2, 100, WIDTH, HEIGHT);
			clearColor		= 0xEEFFFFFF;
			
			var y:uint = 10;
			
			for each (var terrainType:String in Types.ALL_TYPES) {
				
				var terrainDisplay:Canvas = new Canvas(TERRAIN_SYMBOL_WIDTH, TERRAIN_SYMBOL_WIDTH);
				
				if (Tables.TYPE_TEXTURES[terrainType]) {
					
					terrainDisplay.fillTexture(
						new Rectangle(0, 0, TERRAIN_SYMBOL_WIDTH, TERRAIN_SYMBOL_WIDTH),
						Tables.TYPE_TEXTURES[terrainType]);
				}
				
				else {
					
					terrainDisplay.fill(
						new Rectangle(0, 0, TERRAIN_SYMBOL_WIDTH, TERRAIN_SYMBOL_WIDTH),
						Tables.TYPE_COLORS[terrainType]);
				}
				
				addGraphic(terrainDisplay, 0, 10, y);
				
				var terrainName:String = terrainType.substr(0, 1).toUpperCase() + terrainType.substr(1).toLowerCase();
				terrainName = terrainName.replace("_", " ");
				var nameText:Text = new Text(terrainName);
				nameText.color = 0x000000;
				addGraphic(nameText, 0, 10 + TERRAIN_SYMBOL_WIDTH + 10, y);
				
				y += TERRAIN_SYMBOL_WIDTH + 10;
			}
		}
		
	}

}