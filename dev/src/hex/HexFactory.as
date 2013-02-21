package hex {

    import model.PlayerData;

    /**
     *      This guy builds hex tiles. Want a hex tile? Use this guy.
     */
    public class HexFactory {

        private var _playerData:PlayerData;
        private function get playerData():PlayerData { return _playerData; }

        public function HexFactory(playerData:PlayerData) {

            _playerData = playerData;
        }

        public function create(xIndex:uint, yIndex:uint, x:Number, y:Number, radius:Number):HexTile {

            return new HexTile(
                        playerData.getHexData(xIndex, yIndex),
                        xIndex, yIndex,
                        x, y,
                        radius);
        }
    }
}
