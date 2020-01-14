extends Area2D

export var _isActive: bool = true;

export var _linkedToPath: NodePath;
var _linkedPortal;

func _ready():
	_linkedPortal = get(_linkedToPath);

func _on_TPArea_body_entered(body):
	# We need height and that kind of shit
	if (!_isActive):
		return;
	var enterVel : Vector2 = body.linear_velocity;
	body.global_position = _linkedPortal.global_position;
