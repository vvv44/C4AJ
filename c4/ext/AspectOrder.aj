/**
 * Víctor Vargas
 * Felipe Leal
 * Daniel Gomez
 * */

package c4.ext;

/**
 * Class that sets precedence of our aspects since they modify common pointcuts
 * */

public aspect AspectOrder {
	declare precedence: AddSound,AddOpponent, EndGame;
}
