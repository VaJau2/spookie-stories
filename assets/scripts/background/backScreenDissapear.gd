extends ColorRect


func _process(delta: float) -> void:
	if color.a > 0:
		color.a -= delta * 3
	else:
		set_process(false)
