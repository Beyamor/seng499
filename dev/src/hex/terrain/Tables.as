package hex.terrain {
	import common.Assets;
	import net.flashpunk.FP;

    public class Tables {

        public static const TYPE_COLORS:Object = {

            "MUD":     	0xcfbc53,
            "NOT_SAND": 0x5376cf,
			"REEF":		0x336600
        };
		
		public static const TYPE_TEXTURES:Object = {
			
			"MUD":		FP.getBitmap(Assets.IMG_MUD_TEXTURE),
			"REEF":		FP.getBitmap(Assets.IMG_REEF_TEXTURE)
		}
    }
}
