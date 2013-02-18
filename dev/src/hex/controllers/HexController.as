package hex.controllers {

    import hex.HexTile;

    /**
     *  A hex controller responds to actions in the HexView.
     *  The current controller is dependent on the game state.
     */
    public interface HexController {

        function hexSelected(tile:HexTile):void;
    }
}