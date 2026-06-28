extends Node

@export var phone_audi: AudioStreamPlayer2D
@export var take_dialogue_area: DialogueArea
@export var player: CharacterBody2D
@export var phone_anim: AnimationPlayer
@export var next_level: Node


func ring() -> void:
	phone_audi.play()
	take_dialogue_area.is_active = true


func take() -> void:
	phone_audi.stop()
	phone_anim.play("idle")
	player.visible = false
	var movement: MovementController = player.get_node("movement_controller")
	movement.may_move = false


func move_to_lab() -> void:
	next_level.start()
