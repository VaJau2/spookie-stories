extends Button


func _on_pressed() -> void:
	get_parent().visible = false
	Engine.time_scale = 1
