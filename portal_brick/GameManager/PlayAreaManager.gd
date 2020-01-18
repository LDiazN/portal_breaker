extends Node2D

# Play area center
export var origin: Vector2 = Vector2.ZERO;
# Real widht;
export var width: float = 200;
# Half height
export var height: float = 200;

func _ready():
	# El 50 es el ancho de las raquetas
	var lw = get_child(0);
	var rw = get_child(1);
	lw.position = origin - Vector2.RIGHT * (50 + (width / 2));
	rw.position = origin + Vector2.RIGHT * (50 + (width / 2));
	lw.get_node("CollisionShape2D").get_shape().set_extents(Vector2(10, height * 2));
	rw.get_node("CollisionShape2D").get_shape().set_extents(Vector2(10, height * 2));