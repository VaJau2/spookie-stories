extends HSlider

@onready var sample_audi: AudioStreamPlayer = get_node("sample")

const SAMPLE_SOUNDS: Array = [
	preload("res://assets/audio/dialogue/beeps/sound_a.wav"),
	preload("res://assets/audio/dialogue/beeps/sound_e.wav"),
	preload("res://assets/audio/dialogue/beeps/sound_i.wav"),
	preload("res://assets/audio/dialogue/beeps/sound_o.wav"),
	preload("res://assets/audio/dialogue/beeps/sound_i.wav"),
	preload("res://assets/audio/dialogue/beeps/sound_u.wav"),
	preload("res://assets/audio/dialogue/beeps/sound_y.wav"),
]


func _value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_linear(1, new_value)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		sample_audi.stream = SAMPLE_SOUNDS[randi() % len(SAMPLE_SOUNDS)]
		sample_audi.play()
