package hex {

	import flash.geom.Point;
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

        public function create(camera:Point, indices:HexIndices, x:Number, y:Number, radius:Number):HexTile {

            if (!playerData.hexDataExists(indices)) {

				playerData.setHexData(indices,
					cartographer.generateData(indices));
			}

            return new HexTile(
						camera,
                        playerData.getHexData(indices),
                        indices,
                        x, y,
                        radius);
        }
    }
}
