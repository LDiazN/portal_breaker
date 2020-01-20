extends Control
#ball size:
export var ball_radius : int = 16;
#Pading between balls
export var ball_pading : float = 5;
#margin from right
export var left_padding : float = 50;
#margin from top
export var top_padding : float = 100;
#color in ui
export var color : Color = Color.white;
#number of lifes left
var lifes : int = 3;

func _draw():
	#Draw all lifes
	for i in range(lifes):
		draw_circle(Vector2(left_padding, top_padding + i*( ball_radius + ball_pading)), ball_radius, color);