extends Node

class_name PlayerBoxController

@export var box_sprite: Sprite2D
@export var pony_sprite: Sprite2D
@export var box_anim: AnimationPlayer
@export var box_audi: AudioStreamPlayer2D
@export var movement_controller: MovementController
@export var input_controller: InputController

var is_animating: bool = false
var is_hiding: bool = false


func _ready() -> void:
	if get_parent().has_node("without_box"):
		queue_free()

func _process(_delta: float) -> void:
	if is_animating: return
	if is_hiding && (input_controller.is_moving || movement_controller.is_running):
		stop_hiding()
		return
	
	if Input.is_action_just_pressed("ui_interact"):
		is_hiding = !is_hiding
		if is_hiding:
			start_hiding()
		else:
			stop_hiding()


func start_hiding() -> void:
	is_animating = true
	is_hiding = true
	box_sprite.visible = true
	box_anim.play("show")
	box_audi.play()
	movement_controller.load_state("sit")
	await box_anim.animation_finished
	pony_sprite.visible = false
	is_animating = false


func stop_hiding() -> void:
	is_animating = true
	movement_controller.may_move = false
	is_hiding = false
	pony_sprite.visible = true
	box_anim.play("hide")
	await box_anim.animation_finished
	box_sprite.visible = false
	movement_controller.load_state("idle")
	movement_controller.may_move = true
	is_animating = false
