extends Node


func proceed(player: CharacterBody2D) -> void:
	var pies_controller: PiesController = player.get_node("pies_controller")
	pies_controller.pies_count = pies_controller.PIES_MAX_COUNT
