extends Node2D

# Sent when the game is over
signal game_over;
# Sent when its shooting phase
signal shooting_phase;
# Sent when the game starts
signal game_started;

signal paused;

export var counterStart : float = 1;
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

