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
	if (body.name != "Ball"):
		return;
	if (_linkedPortal != null):
		var diff : float = (body.global_position.x - global_position.x);
		# El -1 del transform es just because fuck you godot
		body.global_position = _linkedPortal.global_position + Vector2.RIGHT * diff + \
		body.transform.y.normalized() * -25;
		print(body.transform.y.normalized());
