extends Node

@export var player: CharacterBody2D


func blush_on() -> void:
	player.get_node("blush").visible = true


func blush_off() -> void:
	player.get_node("blush").visible = false
