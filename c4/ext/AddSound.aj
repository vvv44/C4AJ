package c4.ext;

import java.awt.Color;
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

   before(C4Dialog dialog):target(dialog) && execution(void C4Dialog.makeMove(int)){
	  if(dialog.player.name().equals("Red"))
		  pl =0;
	  else
		  pl =1;
   }
	pointcut callMakeMovePointCut():
		execution(void C4Dialog.makeMove(int));
	
	after(): callMakeMovePointCut(){
		if(pl == 0)
			playAudio("scream1.wav");
		else
			playAudio("scream2.wav");
	}
	
}

