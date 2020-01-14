extends Node2D;

# Is the top player racket or the bottom one?
export var isTop: bool = false;

var isActive : bool = true;

# Racket movement speed
export var _speed : float = 10; 
var _actualSpeed : float = 0;

# Play area variables must be in another script (some kind of manager)
# Play area origin
export var playAreaOrigin : Vector2 = Vector2.RIGHT * 200 - Vector2.UP * 110;
# Width of the play area
export var playAreaWidth : float = 20;

# Width of the racket (in units)
export var racketWidth : float = 5;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if (!isActive):
		return;
		
	_actualSpeed = 0;
	
	# Receives top/bottom player input
	# Bottom player moves with A/D
	# Top player moves with LEFT/RIGHT
	if (!isTop):
		if (Input.is_action_pressed("b_racket_left")):
			_actualSpeed = -_speed
		elif (Input.is_action_pressed("b_racket_right")):
			_actualSpeed = _speed;
	else:
		if (Input.is_action_pressed("t_racket_left")):
			_actualSpeed = -_speed
		elif (Input.is_action_pressed("t_racket_right")):
			_actualSpeed = _speed;
	
	 Move(Vector2.RIGHT * _actualSpeed * delta);
	
	# Keeps racket inside play area
	# Maybe make a function
	var xPos : float = global_position.x;
	if (xPos + racketWidth > (playAreaWidth/2) + playAreaOrigin.x):
		var diff : float = abs(xPos + racketWidth - ((playAreaWidth/2) + playAreaOrigin.x));
		Move(-Vector2.RIGHT * diff)
	elif (xPos + racketWidth < playAreaOrigin.x - (playAreaWidth/2)):
		var diff : float = abs(xPos + racketWidth - (playAreaOrigin.x - (playAreaWidth/2)));
		Move(-Vector2.RIGHT * diff);
	else:
		pass;
		
func Move(velocity: Vector2):
	print(velocity);
	var parent: Node2D = get_parent();
	parent.global_position += velocity;
