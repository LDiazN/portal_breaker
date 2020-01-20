extends Node2D

var dp = preload("res://Ball/DeathParticles.tscn");

export var topRacketPath: NodePath;
export var bottomRacketPath: NodePath;
var topRacket = null;
var bottomRacket = null;

signal ball_out;

var playAreaManager;
var gameManager;

# Called when the node enters the scene tree for the first time.
func _ready():

	playAreaManager = get_node("../../PlayAreaManager")
	gameManager = get_node("../../GameManager");
	topRacket = get_node(topRacketPath);
	bottomRacket = get_node(bottomRacketPath);
	

func _process(delta):
	RespawnBall();

# Respawns ball and sets its position
func RespawnBall():
	if (gameManager.lives <= 0):
		return;
	var ki = get_parent();

	# Si se fue por arriba
	if (global_position.y < (playAreaManager.origin + Vector2.UP * (playAreaManager.height + 40)).y):
		ki.DisableBall();
		deathParticles();
		emit_signal("ball_out");
		if (topRacket != null):
			ki.global_position = topRacket.global_position + Vector2.DOWN * 20;
		else:
			ki.global_position = playAreaManager.origin;
		gameManager.loose_life();
		topRacket.get_node("Shooting System").MoreShooty();
	# Si se fue por abajo
	elif (global_position.y > (playAreaManager.origin + Vector2.DOWN * (playAreaManager.height + 40)).y):
		ki.DisableBall();
		deathParticles();
		emit_signal("ball_out");
		if (bottomRacket != null):
			ki.global_position = bottomRacket.global_position + Vector2.UP * 20;
		else:
			ki.global_position = playAreaManager.origin;
		gameManager.loose_life();
		bottomRacket.get_node("Shooting System").MoreShooty();
	
func deathParticles():
		var inst = dp.instance();
		inst.position = global_position;
		get_tree().root.add_child(inst);
		inst.activateParticles();

 