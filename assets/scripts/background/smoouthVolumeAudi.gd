extends AudioStreamPlayer2D


func _ready() -> void:
	volume_linear = 0


func _process(delta: float) -> void:
	if volume_linear < 1:
		volume_linear += delta
	else:
		set_process(false)
