extends Area2D

@export var trigger_button: String
@export var spawn_point: Node2D
@export var player_name: String
@export var door_audi: AudioStreamPlayer2D
@export var door_sound: AudioStream
@export var room_to_enable: Node2D
@export var room_to_disable: Node2D

var player: Node2D



func _ready() -> void:
	set_process(false)


func _process(_delta: float) -> void:
	if Input.is_action_pressed(trigger_button):
		player.global_position = spawn_point.global_position
		var player_camera: Camera2D = player.get_node("camera")
		player_camera.reset_smoothing()
		door_audi.stream = door_sound
		door_audi.play()
		if room_to_disable: room_to_disable.visible = false
		if room_to_enable: room_to_enable.visible = true
		set_process(false)


func _on_body_entered(body: Node2D) -> void:
	if body.name == player_name:
		player = body
		set_process(true)


func _on_body_exited(body: Node2D) -> void:
	if body.name == player_name:
		set_process(false)
