package c4.ext;

import c4.base.*;
import java.util.list;

public privileged aspect EndGame {
    /**Player that is being played so we can choose appropiate sound*/
    int pl;

    before(C4Dialog dialog):target(dialog) && execution(void C4Dialog.makeMove(int)){
        if(dialog.player.name().equals("Red"))
            pl =0;
        else
            pl =1;
    }

    after(C4Dialog dialog):target(dialog) && execution(void C4Dialog.makeMove(int)){
        if(dialog.board.isWonBy(dialog.player)) {
            if (pl == 0)
                dialog.showMessage("red won!");
            else
                dialog.showMessage("blue won!");
            Iterable<Place> winRow = dialog.board.winningRow();
            /*for(Place i : winRow){
              drawChecker(g, RED, i.x, int i.y, boolean true)
            }*/
        }
    }
}
