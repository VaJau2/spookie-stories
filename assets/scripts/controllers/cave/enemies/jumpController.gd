extends Node

@onready var parent: CharacterBody2D = get_parent()

var velocity_y : float = 100


func jump() -> void:
	velocity_y = -150


func _process(delta: float) -> void:
	if velocity_y < 200:
		velocity_y += 500 * delta
	
	parent.velocity.y = velocity_y
