package c4.ext;
import c4.base.*;

import java.awt.*;
import java.awt.event.*;

public privileged aspect pressDisc {
	
	int highlight = -1;
	boolean pressed = false;
	boolean depressed = false;
	ColorPlayer p = new ColorPlayer("Blue", Color.blue);
	
	int around(): execution(int locateSlot(int,int)){
		 int x = proceed();
		 highlight = x;
		 //System.out.print(highlight);
		 return x;
	 }
	
	after(BoardPanel bp):execution(BoardPanel.new(..))&&this(bp){
		 bp.addMouseListener(new MouseAdapter() {
		 
		 public void mousePressed(MouseEvent e) {
			 pressed = true;
			 highlight = bp.locateSlot(e.getX(), e.getY());
			 bp.repaint();
			 System.out.println("Mouse pressed");
		 } 
		 
		 public void mouseReleased(MouseEvent e) {
			 depressed = true;
			 bp.repaint();
			 System.out.println("Mouse depressed");
		 } 
		 });	 
	 }
	
	/**
	 * After the move is made, we check which player is going to move so we can know which player to color
	 */
	before(C4Dialog dialog):target(dialog) && execution(void C4Dialog.makeMove(int)){
		p = dialog.player; 
	}
	   
	void around(BoardPanel bp, Graphics g): execution(void BoardPanel.paint(Graphics))&&args(g) &&this(bp){
		proceed(bp,g);
		if(pressed){
			bp.drawChecker(g,p.color(),highlight,-1,0);
			pressed = false;
		}
		if(depressed){
			if(p.color().equals(Color.RED))
				p = new ColorPlayer("Blue", Color.BLUE);
			else if(p.color().equals(Color.BLUE))
				p = new ColorPlayer("Blue", Color.RED);
		}
			
	}
}
	