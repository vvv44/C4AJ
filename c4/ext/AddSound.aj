/**
 * Víctor Vargas
 * Felipe Leal
 * Daniel Gomez
 * */

package c4.ext;

import java.io.*;
import javax.sound.sampled.*;
import c4.base.*;

public privileged aspect AddSound {
	/** Directory where audio files are stored. */
	   final static String SOUND_DIR = "/sound/";

	/**Player that is being played so we can choose appropiate sound*/
	   int pl;
	   
   /** Play the given audio file. Inefficient because a file will be 
    * (re)loaded each time it is played. */
   public static void playAudio(String filename) {
     try {
       AudioInputStream audioIn = AudioSystem.getAudioInputStream(
	   AddSound.class.getResource(SOUND_DIR + filename));
         Clip clip = AudioSystem.getClip();
         clip.open(audioIn);
         clip.start();
     } catch (UnsupportedAudioFileException 
           | IOException | LineUnavailableException e) {
         e.printStackTrace();
     }
   }

  /**Pointcut to be used by methods*/
	pointcut callMakeMovePointCut():
		execution(void C4Dialog.makeMove(int));
	/**
	 * We will play an audio of winning if the game is over
	 * */
	after(C4Dialog dialog):target(dialog) && callMakeMovePointCut(){
		if(dialog.board.isGameOver())
			playAudio("Win Sound.wav");
	}
	/**Play different audio depending on player that just moved*/
	after(): callMakeMovePointCut(){
		if(pl == 0)
			playAudio("scream1.wav");
		else
			playAudio("scream2.wav");
	}
	/**Set which player used its turn*/
	 before(C4Dialog dialog):target(dialog) && execution(void C4Dialog.makeMove(int)){
		  if(dialog.player.name().equals("Red"))
			  pl =0;
		  else
			  pl =1;
	   }
}

