package hex {

    import hex.terrain.Terrain;
    import hex.terrain.Types;
    import model.PlayerData;
	import map.terrain.TerrainForce;

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

            var terrainType:String = Types.NOT_MUD;

            if ((playerData.hexDataExists(indices.northWest) && playerData.getHexData(indices.northWest).hasNode()) ||
                (playerData.hexDataExists(indices.southWest) && playerData.getHexData(indices.southWest).hasNode())) {

                terrainType = Types.MUD;
				
				//temporary distinguishment between initialized mud tiles and uninitialized tiles
				return new HexData(new Terrain(terrainType), true);
            }

            return new HexData(new Terrain(terrainType), false);
        }
    }
}
