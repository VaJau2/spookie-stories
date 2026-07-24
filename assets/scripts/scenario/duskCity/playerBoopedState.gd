extends Node2D

class_name PlayerBoopedState

@export var sprite: Sprite2D
@export var booped_texture: Texture2D
@export var movement_controller: MovementController
@export var anim_player: AnimationPlayer
@export var audi_boops: AudioStreamPlayer2D

@export var is_booped: bool
var boop_victim: CharacterBody2D


func _ready() -> void:
	anim_player.animation_finished.connect(_on_anim_finished)
	if is_booped: _set_booped()


func _process(_delta: float) -> void:
	if !is_booped: return
	if Input.is_action_just_pressed("ui_boop"):
		print("boop")
		movement_controller.load_state("boop")


func booped() -> void:
	movement_controller.load_state("booped")
	if !is_booped:
		_set_booped()


func _set_booped() -> void:
	movement_controller.get_node("walk").speed = 200
	movement_controller.get_node("run").speed = 350
	sprite.texture = booped_texture
	is_booped = true


func on_boop() -> void:
	if boop_victim == null: return
	var victim_sprite: Sprite2D = boop_victim.get_node("sprite")
	if sprite.flip_h == victim_sprite.flip_h: return
	
	var state_machine: StateMachine = boop_victim.get_node("state_machine")
	state_machine.enable_state("booped")
	audi_boops.play_random()


func _on_anim_finished(anim_name: String) -> void:
	if ["booped", "boop"].has(anim_name):
		if movement_controller.is_running:
			movement_controller.load_state("run")
		else:
			movement_controller.load_state("walk")


func _on_boop_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D && body.has_node("sprite"):
		boop_victim = body


func _on_boop_area_body_exited(body: Node2D) -> void:
	if body == boop_victim: 
		boop_victim = null
		return
