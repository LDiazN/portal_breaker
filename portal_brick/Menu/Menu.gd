extends MarginContainer

export(Resource) var Play_Scene;

func _on_Play_button_up():
	get_tree().change_scene(Play_Scene);
	pass 
