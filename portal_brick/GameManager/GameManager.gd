extends Node2D

export var tmPath : NodePath;
export var tmPath2 : NodePath;
var tm : TileMap;
var tm2 : TileMap;

export var ballPath : NodePath;
var ball;

# Sent when the game is over
signal game_over;
# Sent when its shooting phase
signal shooting_phase;
# Sent when the game starts
signal game_started;
# Sent when the players win
signal win;
# Sent when ball_out
signal update_health(new_health);

export var counterStart : float = 1;
var gameStarted : bool = false;

# Player lives
export var lives : int = 3;
# Amount of blocks to break
var toBreak : int;

func _ready():
	if (tmPath == null or tmPath2 == null or ballPath == null):
		return;
	tm = get_node(tmPath);
	tm2 = get_node(tmPath2);
	toBreak = len(tm.get_used_cells()) + len(tm2.get_used_cells());
	
	ball = get_node(ballPath);
	ball.connect("brick_found", self, "checkIfWon");
	
	# 0 for bottom player and 1 for top player
	var first : int = RandomNumberGenerator.new().randi_range(0,1);

func _process(delta):
	if (!gameStarted):
		if (counterStart > 0):
			counterStart -= delta;
		else:
			gameStarted = true;
			emit_signal("game_started");
	else:
		# Esc to quit
		if (Input.is_action_just_pressed("ui_cancel")):
			get_tree().change_scene("res://Menu/Main_Menu.tscn");

# Reduces player lives and checks if they lost;
func loose_life():
	lives -= 1;
	emit_signal("update_health", lives);
	if (lives > 0):
		emit_signal("shooting_phase");
	else:
		emit_signal("game_over");

# Checks if the players won
func checkIfWon(signalgarbage):
	toBreak -= 1;
	if (toBreak <= 0):
		emit_signal("win");

