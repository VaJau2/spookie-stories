extends Node

@onready var parent: CharacterBody2D = get_parent()


func _process(_delta: float) -> void:
	parent.velocity.y = 100
