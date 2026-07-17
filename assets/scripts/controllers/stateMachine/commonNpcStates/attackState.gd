extends StateBase

@export var seek_areas: Array[Area2D]

var player: CharacterBody2D = null


func enable() -> void:
	super.enable()
	_find_player()
	if player == null: 
		state_machine.enable_state("idle")
		return
	
	if movement_controller is MovementController:
		movement_controller.load_state("run")


func _process(_delta: float) -> void:
	if movement_controller is NavigationMovementController:
		movement_controller.set_target(player.global_position)


func _find_player() -> void:
	if player != null: return
	for seek_area in seek_areas:
		if seek_area.player != null:
			player = seek_area.player
			break
