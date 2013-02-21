package hex {

    import hex.terrain.Terrain;
    import hex.terrain.Types;

    /**
     *      This class generates hex data for the hex view.
     *`     This includes, for example, selecting terrain and features.
     */
    public class Cartographer {

        public function generateData(xIndex:uint, yIndex:uint):HexData {

            return new HexData(new Terrain(Types.NOT_SAND));
        }
    }
}
