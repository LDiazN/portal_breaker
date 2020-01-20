extends MarginContainer


export var GameManager_path : NodePath;

#Score label
onready var Score = $"VBoxContainer/HBoxContainer/Score"
#Instruction label
onready var Instruction : Label = $"VBoxContainer/HBoxContainer/CenterContainer2/CenterContainer/Instructions"
#GameManager object:
onready var GameManager : Node = $"../GameManager"
#Life Counter
onready var lifes : Label = $"VBoxContainer/HBoxContainer/lifes"
# loose message
onready var loose : Label = $"VBoxContainer/HBoxContainer/CenterContainer2/CenterContainer/You Lose"

func _on_GameManager_game_started():
	Instruction.hide()
	pass # Replace with function body.


func _on_ScoreManager_score_updated(new_score : int):
	print("Earned points: ",new_score)
	Score.text = str(new_score);



func _on_update_health(new_health):
	lifes.lifes = new_health;
	lifes.update();
	pass # Replace with function body.


func _on_GameManager_game_over():
	loose.show()
	pass # Replace with function body.
