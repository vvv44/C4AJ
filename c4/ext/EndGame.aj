/**
 * Víctor Vargas
 * Felipe Leal
 * Daniel Gomez
 * */

package c4.ext;

import c4.model.Board.Place;
import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import c4.base.*;

public privileged aspect EndGame{
	/*This will define which player is the one that played and therefore the one that won*/    
	int pl;
	/**The winning row*/
   private Iterable<Place> winRow = new ArrayList<>();
    /**
     * When the paint method for board panel is called we check if we need to highlight a winning row and we do it
     * */
    void around(BoardPanel bp, Graphics g):target(bp) && execution(void BoardPanel.paint(Graphics)) && args(g){
      proceed(bp,g);
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
    /**
     * Before the move is made we check the player's turn and set our local variable to use it
     * */
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
     
     /**
      * Checks if game is over, if so it does not prompt the user for a new game when new game button is clicked.
      * */
     void around(C4Dialog dialog): target(dialog) && execution(void C4Dialog.newButtonClicked(*)){
    	 if(dialog.board.isGameOver())
    		 dialog.startNewGame();
    	 else
    		 proceed(dialog);
     }
    
}