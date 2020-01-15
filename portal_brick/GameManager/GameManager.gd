extends Node2D

signal game_over;
signal shooting_phase;

export var lives = 3;

func loose_life():
	lives -= 1;
	if (lives > 0):
		emit_signal("shooting_phase");
	else:
		lives <= 0;
		emit_signal("game_over");

