package hex {

    import hex.terrain.Terrain;
    import hex.terrain.Types;
    import model.PlayerData;

    /**
     *      This class generates hex data for the hex view.
     *`     This includes, for example, selecting terrain and features.
     */
    public class Cartographer {

        private var _playerData:PlayerData;
        private function get playerData():PlayerData { return _playerData; }

        public function Cartographer(playerData:PlayerData) {

            _playerData = playerData;
        }

        public function generateData(indices:HexIndices):HexData {

            var terrainType:String = Types.NOT_SAND;

            if ((playerData.hexDataExists(indices.northWest) && playerData.getHexData(indices.northWest).hasNode) ||
                (playerData.hexDataExists(indices.southWest) && playerData.getHexData(indices.southWest).hasNode)) {

                terrainType = Types.SAND;
            }

            return new HexData(new Terrain(terrainType));
        }
    }
}
