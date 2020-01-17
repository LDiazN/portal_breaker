extends Node2D
export var ballPath : NodePath;
var ball : KinematicBody2D;

export var isActive : bool = false;
export var isShooting: bool = false;

# Emitted when the ball is shot
signal ball_shot;

# Disables the shooting
func NoMoreShooty():
	isShooting = false;

# Enables the shooting 
func MoreShooty():
	isShooting = true;
	
func _ready():
	ball = get_node(ballPath);	
	if (ball == null):
		print("No ball setted up :( BIG F");
		
		
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
			emit_signal("ball_shot")
			
	
