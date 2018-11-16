package c4.ext;

public aspect AspectOrder {
	declare precedence: AddSound,AddOpponent, EndGame;
}
