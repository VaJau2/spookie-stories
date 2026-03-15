extends AudioStreamPlayer2D

@export var min_time_to_sound: float = 3
@export var max_time_to_sound: float = 8
@export var sounds: Array[AudioStream]

var timer: float = 0

func _ready() -> void:
	var car_stop_scenario = get_node("/root/main/car_stop")
	car_stop_scenario.player_spawned.connect(_on_player_spawned)
	timer = randf_range(min_time_to_sound, max_time_to_sound)
	set_process(false)


func _on_player_spawned() -> void:
	set_process(true)


func _process(delta: float) -> void:
	if timer > 0:
		timer -= delta
	else:
		timer = randf_range(min_time_to_sound, max_time_to_sound)
		stream = sounds[randi() % len(sounds)]
		play()
