extends RigidBody2D

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
	add_central_force( dir.normalized() * speed);
	


func _integrate_forces(state : Physics2DDirectBodyState):
	var n_col : int = state.get_contact_count(); #number of colliding objects
	
	if(n_col >= 1):
		for i in range(n_col):
			print("just found a tile in: ", state.get_contact_collider_position(i));
			emit_signal("brick_found",  
										state.get_contact_local_position(i) + 
										state.get_contact_local_normal(i)*2);
			

# func _on_RigidBody2D_body_entered(body : Node2D) -> void:
#	body entered signal handler.
func _on_RigidBody2D_body_entered(body : Node2D) -> void:
	pass
