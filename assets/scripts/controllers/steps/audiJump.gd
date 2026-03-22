extends AudioStreamPlayer2D

@export var movement_controller: PlatformerMovementController
@export var sound_variants: Array[AudioStream]


func _ready() -> void:
	movement_controller.jumping.connect(on_jump)


func on_jump() -> void:
	stream = sound_variants[randi() % len(sound_variants)]
	play()
