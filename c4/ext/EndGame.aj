package c4.ext;

import c4.base.*;
import java.util.list;

public privileged aspect EndGame {
    /**Player that is being played so we can choose appropiate sound*/
    int pl;
    Iterable<Place> winRow = new ArrayList<>();

    before(C4Dialog dialog):target(dialog) && execution(void C4Dialog.makeMove(int)){
        if(dialog.player.name().equals("Red"))
            pl =0;
        else
            pl =1;
    }

    after(C4Dialog dialog):target(dialog) && execution(void C4Dialog.makeMove(int)){
        if(dialog.board.isWonBy(dialog.player)) {
            if (pl == 0){
                dialog.showMessage("red won!");
                for(Place i : winRow){
                  drawChecker(g, Color.RED, i.x, int i.y, boolean true)
                }
            }
            else{
                dialog.showMessage("blue won!");
                }
            }
            winRow = dialog.board.winningRow();
        }
    }
    after(BoardPanel bp, Graphics g): execution(void BoardPanel.paint(Graphics)) && args(g) && this(bp){
      proceed(bp,g);
      //bp.setDropColor(Color.RED);
      if (pl == 0){
          for(Place i : winRow){
            bp.drawChecker(g, Color.RED, i.x, int i.y, boolean true)
          }
      }
      else{
        for(Place i : winRow){
          bp.drawChecker(g, Color.BLUE, i.x, int i.y, boolean true)
      }
	 }
}
