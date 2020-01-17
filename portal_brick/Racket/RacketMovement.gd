extends Node2D;

# Is the top player racket or the bottom one?
var isTop: bool = false;

var isActive : bool = true;

# Racket movement speed
export var _speed : float = 300; 
var _actualSpeed : float = 0;

# Play area variables must be in another script (some kind of manager)
# Play area origin
var playAreaOrigin: Vector2;
# Width of the play area
var playAreaWidth : float;

# Width of the racket (in units)
# real widht is *2
# this is half
export var racketWidth : float = 5;

# Called when the node enters the scene tree for the first time.
func _ready():
	isActive = false;
	isTop = get_parent()._isTopOne;
	playAreaOrigin = PlayAreaManager.origin;
	playAreaWidth = PlayAreaManager.width;
	
	GameManager.connect("game_started", self, "EnableRacket");
	GameManager.connect("game_over", self, "DisableRacket");

# Conectar a la senal de game_over y de perdida de pelota o shooting_phase
func DisableRacket():
	isActive = false;

# Conectar a la senal de que se disparo la pelota 
func EnableRacket():
	isActive = true;
	
# Just moves the racket
func Move(velocity: Vector2):
	var parent: Node2D = get_parent();
	parent.position += velocity;
	print(parent.position)

func _process(delta):
	#print(Input.is_action_pressed("b_racket_left"))
	if (!isActive):
		return;
		
	_actualSpeed = 0;
	# Receives top/bottom player input
	if (!isTop):
		print(Input.is_action_pressed("b_racket_left"))
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
		Move(Vector2.RIGHT * diff);
	else:
		pass;
		
