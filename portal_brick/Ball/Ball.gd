extends Node2D

export var ballSpeed : float = 100;
export var topRacketPath: NodePath;
export var bottomRacketPath: NodePath;

var topRacket;
var bottomRacket;

func _enter_tree():
	topRacket = get_node(topRacketPath);
	bottomRacket = get_node(bottomRacketPath);