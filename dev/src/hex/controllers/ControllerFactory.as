package hex.controllers {

    import model.Game;
    import hex.HexView;

    /**
     *      Creates controllers based on the game state
     */
    public class ControllerFactory {

        public function createFor(game:Game, hexView:HexView):HexController {

			if (game.state.isConnecting()) {
				
				return new ConnectionStarter(hexView, game);
			}
			
            else if (game.state.isPlacing()) {

                return new InstrumentPlacer(hexView, game);
            }

            else {
                return new TileViewer(hexView, game);
            }
        }

    }
}
