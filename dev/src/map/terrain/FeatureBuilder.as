package map.terrain 
{
	import common.Assets;
	import hex.terrain.Types;
	import net.flashpunk.graphics.Image;
	import hex.terrain.Terrain;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class FeatureBuilder 
	{
		private var location:LocationStructure;
		private var range:Number = 0;
		private var terrain:Terrain = new Terrain(Types.MUD);
		private var mapImage:Image = new Image(Assets.IMG_INSTRUMENT_IMAGE);
		private var spread:int = 0;
		private var initialForce:int = 0;
		private var x:int = 0;
		private var y:int = 0;
		
		public function FeatureBuilder() 
		{

		}
		
		public function setLocationStructure(structure:LocationStructure):FeatureBuilder
		{
			location = structure;
			return this;
		}
		
		public function setRange(r:Number):FeatureBuilder
		{
			range = r;
			return this;
		}
		
		public function setImageCoordinates(x:int, y:int):FeatureBuilder
		{
			this.x = x;
			this.y = y;
			return this;
		}
		public function setImage(image:Image):FeatureBuilder
		{
			mapImage = image;
			return this;
		}
		
		public function setTerrainForceSpread(spread:int):FeatureBuilder
		{
			this.spread = spread;
			return this;
		}
		
		public function setTerrainInitialForce(force:int):FeatureBuilder
		{
			this.initialForce = force;
			return this;
		}
		
		public function setTerrainTile(terr:Terrain):FeatureBuilder
		{
			terrain = terr;
			return this;
		}
		
		public function build():Feature
		{
			return new Feature(location, range, terrain, mapImage, initialForce, spread, x, y);
		}
		
	}

}