package c4.ext;

import c4.base.*;

public aspect EndGame {
    /**Player that is being played so we can choose appropiate sound*/
    int pl;

    before(C4Dialog dialog):target(dialog) && execution(void C4Dialog.makeMove(int)){
        if(dialog.player.name().equals("Red"))
            pl =0;
        else
            pl =1;
    }

    pointcut callMakeMovePointCut():
            execution(void C4Dialog.makeMove(int));

    after(): callMakeMovePointCut(){
        if(Board.isWonBy(dialog.player)) {
            if (pl == 0)
                dialog.showMessage("red won!")
            else
                playAudio("blue won!");
        }
    }
}
