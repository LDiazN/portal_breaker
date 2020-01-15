extends Area2D

export var _isActive: bool = true;

var _linkedPortal;

func _ready():
	var parent = get_parent();
	_linkedPortal = parent.get_node(parent._linkedToPath);

func _on_TPArea_body_entered(body):
	# We need height and that kind of shit
	if (!_isActive):
		return;
	if (_linkedPortal != null):
		# var enterVel : Vector2 = body.linear_velocity;
		body.global_position = _linkedPortal.global_position
