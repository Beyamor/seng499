package hex.terrain {

    public class Types {

        public static const SAND:String         = "SAND";
        public static const NOT_SAND:String     = "NOT_SAND";

        public static const ALL_TYPES:Vector.<String> = new Vector.<String>;
        ALL_TYPES.push(SAND);
        ALL_TYPES.push(NOT_SAND);

        public static function getAny():String {

            return ALL_TYPES[Math.floor(Math.random() * ALL_TYPES.length)];
        }
    }
}
