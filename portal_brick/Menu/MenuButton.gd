extends TextureButton

onready var light = $light;
onready var dark = $dark;

export(String, FILE, "*.tscn,*.scn") var play_scene_path;

#Show the dark skin text when mouse is over
func _on_Play_mouse_entered():
	mouse_default_cursor_shape = CURSOR_POINTING_HAND;
	light.hide()
	dark.show()

#Show the ligth skin text when mouse is not hover
func _on_Play_mouse_exited():
	mouse_default_cursor_shape = CURSOR_ARROW;
	dark.hide()
	light.show()

#Change scene when button is pressed
func _on_Play_button_up():
	get_tree().change_scene(play_scene_path);
	pass # Replace with function body.
