package c4.ext;
import c4.base.BoardPanel;

import java.awt.Color;
import java.awt.Graphics;


public privileged aspect pressDisc {
	
	int highlight = -1;
	
	int around(): execution(int locateSlot(int,int)){
		 int x = proceed();
		 highlight = x;
		 System.out.print(highlight);
		 return x;
	 }
	
	void around(BoardPanel bp, Graphics g): execution(void BoardPanel.paint(Graphics)) && args(g) && this(bp){
		 proceed(bp,g);
		 //bp.setDropColor(Color.RED);
		 bp.drawChecker(g, Color.WHITE, highlight, -1, 5);
	 }
	
	//void after(C4Dialog c4, ActionEvent event): 
	//	execution(void C4Dialog.)
	

	
}
