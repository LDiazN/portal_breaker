extends Node2D

export var timeMultiplier : float = 0;
export var multiplierCap : float = 2;
export var timePerLevel : float = 10;
var counter : float = 10;
var start: bool = false;
var score : float = 0;

func _enter_tree():
	start = false;
	counter = timePerLevel;
	GameManager.connect("game_started", self, "startCounter");

func startCounter():
	start = true;
	
func updateScore():
	score = floor(score + score * timeMultiplier);
	
func _process(delta):
	if (!start):
		return;
	else:
		if (timeMultiplier == multiplierCap):
			return;
		elif (counter > 0 and timeMultiplier != multiplierCap):
			counter -= delta;
		elif (counter <= 0 and timeMultiplier != multiplierCap):
			counter = timePerLevel;
			timeMultiplier = min(0.25 + timeMultiplier, multiplierCap);
			
		
		