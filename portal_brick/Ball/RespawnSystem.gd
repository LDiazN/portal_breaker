extends Node2D

export var topRacketPath: NodePath;
export var bottomRacketPath: NodePath;
var topRacket = null;
var bottomRacket = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	var ki = get_parent();
	topRacket = get_node(topRacketPath);
	bottomRacket = get_node(bottomRacketPath);
	
	ki.connect("ball_out", self, "RespawnBall");

func RespawnBall():
	if (GameManager.lives <= 0):
		return;
	var ki = get_parent();
	ki.DisableBall();
	
	# Si se fue por arriba
	if (global_position.y < (PlayAreaManager.origin + Vector2.UP * PlayAreaManager.height).y):
		print("por arriba");
		if (topRacket != null):
			print(topRacket.global_position)
			ki.global_position = topRacket.global_position + Vector2.DOWN * 20;
		else:
			print("error");
			ki.global_position = PlayAreaManager.origin;
	# Si se fue por abajo
	elif (global_position.y > (PlayAreaManager.origin + Vector2.DOWN * PlayAreaManager.height).y):
		if (bottomRacket != null):
			ki.global_position = bottomRacket.global_position + Vector2.UP * 20;
		else:
			ki.global_position = PlayAreaManager.origin;
			print("error");
		print("por abajo");
	
	

 