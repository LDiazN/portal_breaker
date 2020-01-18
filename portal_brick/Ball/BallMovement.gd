extends KinematicBody2D

export var speed : float = 10;
export var dir : Vector2 = Vector2.DOWN + Vector2.RIGHT;
export var isMoving : bool = false;

signal ball_out;
signal brick_found;

func _ready():
	isMoving = false;
	
	GameManager.connect("game_started", self, "EnableBall");
	GameManager.connect("game_over", self, "DestroyBall");

# Enables ball movement
func EnableBall():
	isMoving = true;
	
# Disables ball movement
func DisableBall():
	isMoving = false;
	
# Changes ball movement dir and shoots the ball
func ShootMe(newDir : Vector2):
	dir = newDir;
	EnableBall();
	
# Destroy ball
func DestroyBall():
	queue_free();
	
func _physics_process(delta):
	if (!isMoving):
		return;
		
	var coll = move_and_collide(dir * speed * delta);
	
	# Checks if the ball is in the play area
	if (global_position.y < (PlayAreaManager.origin + Vector2.UP * (PlayAreaManager.height + 10)).y or
		global_position.y > (PlayAreaManager.origin + Vector2.DOWN * (PlayAreaManager.height + 10)).y):
		emit_signal("ball_out");
		
	# Process the collisions;
	if (coll != null):
		var normal : Vector2 = coll.normal;
		var reflex : Vector2 = dir.bounce(normal);
		dir = reflex;
		if (coll.collider.name == "Tiles" or coll.collider.name == "Tiles2"):
			emit_signal("brick_found", coll.position - coll.normal);