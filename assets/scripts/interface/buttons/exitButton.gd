extends Button


func _pressed() -> void:
	if OS.get_name() != "Web":
		get_tree().quit()
