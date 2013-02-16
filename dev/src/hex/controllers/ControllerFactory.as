package hex.controllers {

    import model.Game;
    import hex.HexView;

    /**
     *      Creates controllers based on the game state
     */
    public class ControllerFactory {

        public function createFor(game:Game, hexView:HexView):HexController {

           // So, uh, once the game state actually has, y'know, state
           // this should, uh, read that state
           return new InstrumentPlacer;
        }
    }
}
