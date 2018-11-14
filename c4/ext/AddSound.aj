package c4.ext;

import java.io.*;
import javax.sound.sampled.*;
import c4.base.*;


public privileged aspect AddSound {
	/** Directory where audio files are stored. */
	   final static String SOUND_DIR = "/sound/";

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
	pointcut callMakeMovePointCut():
		execution(void C4Dialog.makeMove(int));
	after(): callMakeMovePointCut(){
		playAudio("Potential Player 1-3 low wav.wav");
	}
	
}

