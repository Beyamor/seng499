package hex.terrain {

    public class Types {

        public static const MUD:String         = "MUD";
        public static const UNDISCOVERED:String     = "UNDISCOVERED";
		public static const REEF:String			= "REEF"

        public static const ALL_TYPES:Vector.<String> = new <String>[
			MUD,
			UNDISCOVERED,
			REEF
		];

        public static function getAny():String {

            return ALL_TYPES[Math.floor(Math.random() * ALL_TYPES.length)];
        }
    }
}
