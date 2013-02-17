package hex.controllers {

    import model.Game;
    import hex.HexView;

    /**
     *      Creates controllers based on the game state
     */
    public class ControllerFactory {

        public function createFor(game:Game, hexView:HexView):HexController {

            if (game.state.getPlacing()) {

                return new InstrumentPlacer(
                                hexView,
                                game.state.getInstrumentBeingPlaced().getInstrument());
            }

            else {

                return new TileViewer;
            }
        }

    }
}
