package hex.terrain {

    public class Types {

        public static const MUD:String         = "MUD";
        public static const NOT_MUD:String     = "NOT_SAND";
		public static const REEF:String			= "REEF"

        public static const ALL_TYPES:Vector.<String> = new Vector.<String>;
        ALL_TYPES.push(MUD);
        ALL_TYPES.push(NOT_MUD);

        public static function getAny():String {

            return ALL_TYPES[Math.floor(Math.random() * ALL_TYPES.length)];
        }
    }
}
