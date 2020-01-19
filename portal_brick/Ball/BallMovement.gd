extends KinematicBody2D

export var speed : float = 10;
export var dir : Vector2 = Vector2.DOWN + Vector2.RIGHT;
export var isMoving : bool = false;
export var ball_radius : float = 16
export var color : Color = Color.white;

signal ball_out;
signal brick_found;
# Emitted when the ball is shot
signal ball_shot;


var gameManager;

func _ready():
	isMoving = false;
	gameManager = get_node("../GameManager");
	
	gameManager.connect("game_started", self, "EnableBall");
	gameManager.connect("game_over", self, "DestroyBall");
	
	get_node("Ball Collider").shape.radius = ball_radius - 8;

# Enables ball movement
func EnableBall():
	isMoving = true;
	
# Disables ball movement
func DisableBall():
	isMoving = false;
	
# Changes ball movement dir and shoots the ball
func ShootMe(newDir : Vector2):
	dir = newDir;
	emit_signal("ball_shot")
	EnableBall();
	
# Destroy ball
func DestroyBall():
	queue_free();
	
func _physics_process(delta):
	if (!isMoving):
		return;
		
	var coll: KinematicCollision2D = move_and_collide(dir * speed * delta);
		
	# Process the collisions;
	if (coll != null):
		var normal : Vector2 = coll.normal;
		var reflex : Vector2 = dir.bounce(normal);
		dir = reflex;
		if (coll.collider.name == "Tiles" or coll.collider.name == "Tiles2"):
			emit_signal("brick_found", coll.position - coll.normal);
			
func _draw():
	draw_circle(Vector2.ZERO, ball_radius, color)
	
	
	
	
	
	
	