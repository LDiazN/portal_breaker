extends KinematicBody2D

export(float) var speed;
export(NodePath) var node;
var dir : Vector2;

signal brick_found(pos);

func _process(delta):
	
	if(Input.is_action_pressed("ui_left")):
		dir.x = -1
	elif (Input.is_action_pressed("ui_right")):
		dir.x = 1
	else:
		dir.x = 0
		
	if(Input.is_action_pressed("ui_up")):
		dir.y = -1
	elif (Input.is_action_pressed("ui_down")):
		dir.y = 1
	else:
		dir.y = 0
	
	
func _physics_process(delta):
	var col : KinematicCollision2D;
	col = move_and_collide(dir*speed);
	if col != null:
		print(col.position);
		emit_signal("brick_found", col.position - col.normal);
	

