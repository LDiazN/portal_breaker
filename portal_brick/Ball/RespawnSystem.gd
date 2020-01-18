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

# Respawns ball and sets its position
func RespawnBall():
	if (GameManager.lives <= 0):
		return;
	var ki = get_parent();
	ki.DisableBall();
	
	# Si se fue por arriba
	if (global_position.y < (PlayAreaManager.origin + Vector2.UP * (PlayAreaManager.height + 10)).y):
		print("por arriba");
		if (topRacket != null):
			ki.global_position = topRacket.global_position + Vector2.DOWN * 20;
			print(topRacket.global_position)
		else:
			ki.global_position = PlayAreaManager.origin;
		topRacket.get_node("Shooting System").MoreShooty();
	# Si se fue por abajo
	elif (global_position.y > (PlayAreaManager.origin + Vector2.DOWN * (PlayAreaManager.height + 10)).y):
		if (bottomRacket != null):
			ki.global_position = bottomRacket.global_position + Vector2.UP * 20;
		else:
			ki.global_position = PlayAreaManager.origin;
		bottomRacket.get_node("Shooting System").MoreShooty();
		print("por abajo");
		print(bottomRacket.global_position)
	
	

 