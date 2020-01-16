extends Node2D

export var _linkedToPath: NodePath;
export var _isTopOne: bool;

func _ready():
	if (_isTopOne):
		global_position = PlayAreaManager.origin + Vector2.UP * PlayAreaManager.height;
		global_rotation_degrees = 180;
	else:
		global_position = PlayAreaManager.origin - Vector2.UP * PlayAreaManager.height;
	pass