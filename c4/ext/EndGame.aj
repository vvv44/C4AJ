package c4.ext;

import c4.model.Board.Place;
import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import c4.base.*;

public privileged aspect EndGame{
	/*This will define which player is the one that played and therefore the one that won*/    
	int pl;
	
   private Iterable<Place> winRow = new ArrayList<>();
      
    void around(BoardPanel bp, Graphics g):target(bp) && execution(void BoardPanel.paint(Graphics)) && args(g){
      proceed(bp,g);
      //bp.setDropColor(Color.RED);
      if (pl == 0){
          for(Place i : winRow){
            bp.drawChecker(g, Color.RED, i.x, i.y, true);
          }
      }
      else{
        for(Place i : winRow){
        		
        	bp.drawChecker(g, Color.BLUE, i.x, i.y, true);
        }
      }
    }
    /**
     * 
     * Pointcut in common to apply two advices, the before adivec is applied first
     * */
    pointcut makeMovePoint():
    	execution(void C4Dialog.makeMove(int));
    
    before(C4Dialog dialog):target(dialog) && makeMovePoint(){
        if(dialog.player.name().equals("Red"))
            pl =0;
        else
            pl =1;
    }
    /**
     * Checks if current player has a winnning row
     * */
    
     after(C4Dialog dialog):target(dialog) && makeMovePoint(){
         if(dialog.board.isWonBy(dialog.player)) {
             if (pl == 0){
                 dialog.showMessage("red won!");
             }
             else{
                 dialog.showMessage("blue won!");
             }
             winRow = dialog.board.winningRow();
         }
     }
     
    
}