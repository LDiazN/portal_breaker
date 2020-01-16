extends KinematicBody2D

export var speed : float = 10;
var dir : Vector2 = Vector2.DOWN;
var isMoving : bool = false;

signal ball_out;

func _ready():
	isMoving = false;
	
	GameManager.connect("game_started", self, "EnableBall");
	GameManager.connect("game_over", self, "DestroyBall");

func EnableBall():
	isMoving = true;
	
func DestroyBall():
	queue_free();
	
func _physics_process(delta):
	if (!isMoving):
		return;
	if (global_position.y < (PlayAreaManager.origin + Vector2.UP * PlayAreaManager.height).y or
		global_position.y > (PlayAreaManager.origin + Vector2.DOWN * PlayAreaManager.height).y):
		emit_signal("ball_out");
		
	var coll = move_and_collide(dir * speed * delta);
	if (coll != null):
		var normal : Vector2 = coll.normal;
		var reflex : Vector2 = dir.bounce(normal);
		dir = reflex;