extends Node2D

var topRacket = null;
var bottomRacket = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	var ki = get_parent();
	topRacket = ki.topRacket;
	bottomRacket = ki.bottomRacket;
	
	ki.connect("ball_out", self, "RespawnBall");

func RespawnBall():
	if (GameManager.lives <= 0):
		return;
	var ki = get_parent();
	ki.DisableBall();
	
	# Si se fue por arriba
	if (global_position.y < (PlayAreaManager.origin + Vector2.UP * PlayAreaManager.height).y):
		print("por arriba");
		ki.global_position = PlayAreaManager.origin;
	# Si se fue por abajo
	elif (global_position.y > (PlayAreaManager.origin + Vector2.DOWN * PlayAreaManager.height).y):
		ki.global_position = PlayAreaManager.origin;
		print("por abajo")
	
	

 