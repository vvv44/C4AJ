/**
 * Víctor Vargas
 * Felipe Leal
 * Daniel Gomez
 * */


package c4.ext;
import c4.base.*;

import java.awt.*;
import java.awt.event.*;

/**
 * Class that modifies behavior when pressing discs.
 * */

public privileged aspect pressDisc {
	
	int highlight = -1; //variable to know which disk is being pressed
	boolean pressed = false; 
	boolean depressed = false;
	/**Our local way of knowing the player's turn*/
	ColorPlayer p = new ColorPlayer("Blue", Color.blue);
	
	/**
	 * Method to know which slot was clicked to use in other parts of this aspect
	 * */
	int around(): execution(int locateSlot(int,int)){
		 int x = proceed();
		 highlight = x;
		 //System.out.print(highlight);
		 return x;
	 }
	/**
	 * We add these two methods to the board panel's mouse listener.
	 * */
	after(BoardPanel bp):execution(BoardPanel.new(..))&&this(bp){
		 bp.addMouseListener(new MouseAdapter() {
		 
		 public void mousePressed(MouseEvent e) {
			 pressed = true; //set pressed variable
			 highlight = bp.locateSlot(e.getX(), e.getY()); //set slot that was pressed
			 bp.repaint();
		 } 
		 
		 public void mouseReleased(MouseEvent e) {
			 depressed = true;
			 bp.repaint();
		 } 
		 });	 
	 }
	
	/**
	 * After the move is made, we check which player is going to move so we can know which player to color
	 */
	before(C4Dialog dialog):target(dialog) && execution(void C4Dialog.makeMove(int)){
		p = dialog.player; 
	}
	/**
	 * When the board panel sis going to be painted we paint it, then draw soime specific checkers depending on behavior
	 * */
	void around(BoardPanel bp, Graphics g): execution(void BoardPanel.paint(Graphics))&&args(g) &&this(bp){
		proceed(bp,g);
		if(pressed){//if mouse is pressed we draw the checker slightly bigger
			bp.drawChecker(g,p.color(),highlight,-1,0);
			pressed = false;
		}
		if(depressed){//when mouse is depressed we invert the turn, since the whole board panel is going to be repainted for the next turn
			if(p.color().equals(Color.RED))
				p = new ColorPlayer("Blue", Color.BLUE);
			else if(p.color().equals(Color.BLUE))
				p = new ColorPlayer("Blue", Color.RED);
		}
			
	}
}
	