extends Node2D
export var ballPath : NodePath;
var ball : KinematicBody2D;

# Indicates if the shooting system is active
export var isActive : bool = false;
# Indicates if the racket is shooting
export var isShooting: bool = false;
# Indicates if it is the top racket
var isTop;
var gameManager;

func _ready():
	ball = get_node(ballPath);	
	gameManager = get_node("../../GameManager");
	if (ball == null):
		print("No ball setted up :( BIG F");
	isTop = get_parent()._isTopOne;
		
# Disables the shooting
func NoMoreShooty():
	isShooting = false;

# Enables the shooting 
func MoreShooty():
	if (gameManager.lives > 0):
		isShooting = true;

func _process(delta):
	if (!isActive):
		return;
	if (isShooting):
		var mousePos : Vector2 = get_global_mouse_position();
		# Shooting dir
		var dir = (global_position - mousePos).normalized();
		if (Input.is_action_just_pressed("shoot_ball")):
			ball.ShootMe(-dir);
			NoMoreShooty();
	
