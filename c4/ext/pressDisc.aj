package c4.ext;
import c4.base.*;
import java.awt.Graphics;
import java.awt.*;
import java.awt.event.*;

public privileged aspect pressDisc {
	
	int highlight = -1;
	boolean pressed = false;
	boolean depressed = false;
	
	int around(): execution(int locateSlot(int,int)){
		 int x = proceed();
		 highlight = x;
		 //System.out.print(highlight);
		 return x;
	 }
	
	after(BoardPanel bp):execution(BoardPanel.new(..))&&this(bp){
		 bp.addMouseListener(new MouseAdapter() {
		 
		 public void mousePressed(MouseEvent e) {
			 bp.repaint();
			 System.out.println("Mouse pressed"); 
		 } 
		 
		 public void mouseReleased(MouseEvent e) {
			 //bp.repaint();
			 System.out.println("Mouse depressed");
		 } 
		 });	 
	 }
	
	void around(BoardPanel bp, Graphics g): execution(void BoardPanel.paint(Graphics))&&args(g) &&this(bp){
		proceed(bp,g);
		
		bp.drawChecker(g,Color.WHITE,highlight,-1,5);
		
		
		
		
	}
}
	


