package hex {

    import model.PlayerData;

    /**
     *      This guy builds hex tiles. Want a hex tile? Use this guy.
     */
    public class HexFactory {

        private var _playerData:PlayerData;
        private function get playerData():PlayerData { return _playerData; }

        private var _cartographer:Cartographer;
        private function get cartographer():Cartographer { return _cartographer; }

        public function HexFactory(cartographer:Cartographer, playerData:PlayerData) {

            _cartographer   = cartographer;
            _playerData     = playerData;
        }

        public function create(xIndex:uint, yIndex:uint, x:Number, y:Number, radius:Number):HexTile {

            if (!playerData.hexDataExists(xIndex, yIndex)) {

                playerData.setHexData(xIndex, yIndex,
                    cartographer.generateData(xIndex, yIndex));
            }

            return new HexTile(
                        playerData.getHexData(xIndex, yIndex),
                        xIndex, yIndex,
                        x, y,
                        radius);
        }
    }
}
