extends CheckBox


func _pressed() -> void:
	DisplayServer.window_set_mode(\
		DisplayServer.WINDOW_MODE_FULLSCREEN if button_pressed\
		else DisplayServer.WINDOW_MODE_WINDOWED\
	)
