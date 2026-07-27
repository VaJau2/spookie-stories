extends Node

static var first_time: bool = true
@export var hint: HintLabel


func may_enter(player: CharacterBody2D) -> bool:
	var pies_controller: PiesController = player.get_node("pies_controller")
	return pies_controller.pies_count < pies_controller.PIES_MAX_COUNT


func proceed(player: CharacterBody2D) -> void:
	var pies_controller: PiesController = player.get_node("pies_controller")
	pies_controller.pies_count = pies_controller.PIES_MAX_COUNT


func proceed_exit() -> void:
	if first_time:
		hint.hint_key = "pie"
		hint.show_hint()
		first_time = false
