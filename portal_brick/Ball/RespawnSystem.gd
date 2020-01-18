extends Node2D

export var topRacketPath: NodePath;
export var bottomRacketPath: NodePath;
var topRacket = null;
var bottomRacket = null;

signal ball_out;

# Called when the node enters the scene tree for the first time.
func _ready():
	var ki = get_parent();
	topRacket = get_node(topRacketPath);
	bottomRacket = get_node(bottomRacketPath);
	

func _process(delta):
	RespawnBall();

# Respawns ball and sets its position
func RespawnBall():
	if (GameManager.lives <= 0):
		return;
	var ki = get_parent();

	# Si se fue por arriba
	if (global_position.y < (PlayAreaManager.origin + Vector2.UP * (PlayAreaManager.height + 10)).y):
		print("por arriba");
		ki.DisableBall();
		if (topRacket != null):
			ki.global_position = topRacket.global_position + Vector2.DOWN * 20;
			print(topRacket.global_position)
		else:
			ki.global_position = PlayAreaManager.origin;
		emit_signal("ball_out");
		GameManager.loose_life();	
		topRacket.get_node("Shooting System").MoreShooty();
	# Si se fue por abajo
	elif (global_position.y > (PlayAreaManager.origin + Vector2.DOWN * (PlayAreaManager.height + 10)).y):
		ki.DisableBall();
		if (bottomRacket != null):
			ki.global_position = bottomRacket.global_position + Vector2.UP * 20;
		else:
			ki.global_position = PlayAreaManager.origin;
		emit_signal("ball_out");
		GameManager.loose_life();
		bottomRacket.get_node("Shooting System").MoreShooty();
	
	

 