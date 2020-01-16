extends KinematicBody2D

export var speed : float = 10;
export var dir : Vector2 = Vector2.DOWN + Vector2.RIGHT;
export var isMoving : bool = false;

signal ball_out;
signal brick_found;

export var topRacketPath: NodePath;
export var bottomRacketPath: NodePath;

var topRacket;
var bottomRacket;

func _enter_tree():
	topRacket = get_node(topRacketPath);
	bottomRacket = get_node(bottomRacketPath);
	
func _ready():
	isMoving = false;
	
	GameManager.connect("game_started", self, "EnableBall");
	GameManager.connect("game_over", self, "DestroyBall");

# Enables ball movement
func EnableBall():
	isMoving = true;
func DisableBall():
	isMoving = false;
	
# Destroy ball
func DestroyBall():
	queue_free();
	
func _physics_process(delta):
	if (!isMoving):
		return;
		
	var coll = move_and_collide(dir * speed * delta);
	
	if (global_position.y < (PlayAreaManager.origin + Vector2.UP * PlayAreaManager.height).y or
		global_position.y > (PlayAreaManager.origin + Vector2.DOWN * PlayAreaManager.height).y):
		emit_signal("ball_out");
		
	if (coll != null):
		var normal : Vector2 = coll.normal;
		var reflex : Vector2 = dir.bounce(normal);
		dir = reflex;
		if (coll.collider.name == "Tiles" or coll.collider.name == "Tiles2"):
			emit_signal("brick_found", coll.position - coll.normal);