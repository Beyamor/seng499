package map 
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class MapWorld 
	{
		
		
		public function MapWorld() 
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