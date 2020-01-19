extends Node2D

export var ballPath : NodePath;
# Current score multiplier
export var timeMultiplier : float = 0;
# Max score multiplier value
export var multiplierCap : float = 2;
# Time per multiplier grow
export var timePerLevel : float = 10;
# Multiplier counter
var counter : float = 10;
# Indicates if the counter started
var start: bool = false;
# Players score
var score : float = 0;
var gameManager;
var ball;

# Sent when the score is updated
signal score_updated;

func _enter_tree():
	start = false;
	counter = timePerLevel;
	
	ball = get_node(ballPath);
	
	gameManager = get_node("../GameManager");
	gameManager.connect("game_started", self, "startCounter");
	
	ball.connect("brick_found", self, "updateScore");
	ball.get_node("RespawnSystem").connect("ball_out", self, "restartMultiplier");
	ball.get_node("RespawnSystem").connect("ball_out", self, "stopCounter");
	ball.connect("ball_shot", self, "startCounter");
	
func startCounter():
	start = true;

func stopCounter():
	start = false;

# Restart score multiplier
func restartMultiplier():
	timeMultiplier = 0;
	counter = timePerLevel;
	
# Updates players score
func updateScore(signalgarbage):
	score += floor(100 + 100 * timeMultiplier);
	emit_signal("score_updated");

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
		