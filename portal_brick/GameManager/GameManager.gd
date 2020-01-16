extends Node2D

signal game_over;
signal shooting_phase;
signal game_started;

var counterStart : float = 4;
var gameStarted : bool = false;

export var lives : int = 3;

func _process(delta):
	if (!gameStarted):
		if (counterStart > 0):
			counterStart -= delta;
		else:
			gameStarted = true;
			emit_signal("game_started");
	
func loose_life():
	lives -= 1;
	if (lives > 0):
		emit_signal("shooting_phase");
	else:
		lives <= 0;
		emit_signal("game_over");

