package map 
{
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class MapView extends World
	{
		
		
		public function MapView() 
		{
			add(new Node(70, 70));
		}
		
		override public function update():void 
		{
			super.update();
			
			const speed:Number = 5;
			
			if (Input.check("hex-scroll-up"))		FP.camera.y -= speed;
			if (Input.check("hex-scroll-down"))		FP.camera.y += speed;
			if (Input.check("hex-scroll-left"))		FP.camera.x -= speed;
			if (Input.check("hex-scroll-right"))	FP.camera.x += speed;
		}
		
	}

}