extends Node

@export var is_active: bool = false

func may_enter(player: CharacterBody2D) -> bool:
	if !is_active: return false
	
	var booped_state: PlayerBoopedState = player.get_node("booped_state")
	if booped_state.is_booped: return false
	
	var pies_controller: PiesController = player.get_node("pies_controller")
	return pies_controller.pies_count > 0


func proceed(player: CharacterBody2D) -> void:
	var pies_controller: PiesController = player.get_node("pies_controller")
	pies_controller.set_healing_pies_count(pies_controller.pies_count)
