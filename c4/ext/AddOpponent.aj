package c4.ext;

import java.awt.Color;
import java.util.*;
import c4.base.*;

public privileged aspect AddOpponent{
	   /** Two players of the game. */
	   private List<ColorPlayer> players = new LinkedList<ColorPlayer>();
	   
	   /** Change the turn after a player’s move. */
	   private void C4Dialog.changeTurn(ColorPlayer opponent) {
	       player = opponent;
	       showMessage(player.name() + "'s turn.");
	       repaint();
	   }
	   /**Before the UI is configured we will add two players to our list of players, one red and one blue*/
	   before(): call (void C4Dialog.configureUI()){
		   ColorPlayer blue = new ColorPlayer("Blue", Color.BLUE);
		   players.add(blue);
		   players.add(new ColorPlayer("Red", Color.RED));
	   }
	   
	   after(C4Dialog dialog):target(dialog) && execution(void C4Dialog.makeMove(int)){
		   if(!dialog.board.isGameOver()){
			   if(dialog.player.name().equals("Red"))
				   dialog.player  = players.get(0);
			   else
				   dialog.player = players.get(1);
			   dialog.changeTurn(dialog.player);
		   }
	   }
	   
	   
	   before(C4Dialog dialog):target(dialog) && execution(void C4Dialog.startNewGame()){
		   if(dialog.player.name().equals("Red"))
			   dialog.player  = players.get(0);
	   }
	   
}
