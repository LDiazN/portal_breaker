extends KinematicBody2D

export var speed : float = 10;
var velocity = Vector2.DOWN;

func _physics_process(delta):
	var coll = move_and_collide(velocity * speed * delta);
	if (coll != null):
		var normal : Vector2 = coll.normal;
		var reflex : Vector2 = velocity.bounce(normal);
		velocity = reflex;