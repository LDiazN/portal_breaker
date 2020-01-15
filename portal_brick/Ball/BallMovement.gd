extends KinematicBody2D

export var speed : float = 10;
var velocity = Vector2.DOWN;

func _physics_process(delta):
	var coll = move_and_collide(velocity * speed * delta);
	if (coll != null):
		var normal : Vector2 = coll.normal;
		if (normal == Vector2.UP or normal == Vector2.DOWN or
			normal == Vector2.RIGHT or normal == Vector2.LEFT):
				var reflex : Vector2 = velocity.bounce(normal);
				velocity = reflex;
		else:
			var reflex : Vector2 = velocity.bounce(normal);
			velocity = reflex;