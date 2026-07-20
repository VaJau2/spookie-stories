extends Node

@export var dialogue_menu: DialogueMenu


func proceed(player: CharacterBody2D) -> void:
	player.get_node("bow").visible = true


func proceed_exit() -> void:
	dialogue_menu.start_dialogue("dusk_city", "after_bow_shop")
