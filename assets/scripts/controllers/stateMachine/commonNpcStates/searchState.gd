extends StateBase

@export var seek_areas: Array[Area2D]
@export var anim_controller: AnimationController

const SEARCH_TIME: Array[float] = [2, 5]
var search_timer: float

const FLIP_TIME: Array[float] = [0.1, 1]
var flip_timer: float
var is_flip: bool


func enable() -> void:
	super.enable()
	var player = _find_player()
	if player == null: 
		state_machine.enable_state("idle")
		return
	
	if movement_controller is NavigationMovementController:
		movement_controller.load_state("walk")
		movement_controller.set_target(player.global_position)
	
	search_timer = randf_range(SEARCH_TIME[0], SEARCH_TIME[1])


func _process(delta: float) -> void:
	_update_flip(delta)
	
	if search_timer > 0:
		search_timer -= delta
	else:
		state_machine.enable_state("idle")


func _find_player() -> CharacterBody2D:
	var player = null
	
	for seek_area in seek_areas:
		if seek_area.player != null:
			player = seek_area.player
			break
	
	return player

func _update_flip(delta: float) -> void:
	if flip_timer > 0:
		flip_timer -= delta
	else:
		anim_controller.set_flip(is_flip)
		is_flip = !is_flip
		flip_timer = randf_range(FLIP_TIME[0], FLIP_TIME[1])
