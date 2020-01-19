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
		# Ball distance between entry point and racket center
		var diff : float = (body.global_position.x - global_position.x);

		if (get_parent()._isTopOne):
			body.global_position = _linkedPortal.global_position + Vector2.RIGHT * diff + \
			Vector2.UP * 25;
		else:
			body.global_position = _linkedPortal.global_position + Vector2.RIGHT * diff + \
			Vector2.UP * -25;			
