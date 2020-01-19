extends Node2D

export var _linkedToPath: NodePath;
export var _isTopOne: bool;
var playAreaManager;

func _ready():
	playAreaManager = get_node("../PlayAreaManager")
	if (_isTopOne):
		position = playAreaManager.origin + Vector2.UP * playAreaManager.height;
		global_rotation_degrees = 180;
	else:
		global_rotation_degrees = 0;
		position = playAreaManager.origin - Vector2.UP * playAreaManager.height;