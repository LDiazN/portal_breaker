extends TextureButton

onready var light = $light;
onready var dark = $dark;

#Show the dark skin text when mouse is over
func _on_Play_mouse_entered():
	mouse_default_cursor_shape = CURSOR_POINTING_HAND;
	light.hide()
	dark.show()


func _on_Play_mouse_exited():
	mouse_default_cursor_shape = CURSOR_ARROW;
	dark.hide()
	light.show()
