extends Area2D

@onready var parent: CharacterBody2D = get_parent()
@export var audi: AudioStreamPlayer2D


func _on_body_entered(body: Node2D) -> void:
	if parent.velocity.y < 200: return
	
	if body.has_node("die_controller"):
		var controller = body.get_node("die_controller")
		controller.die()
		audi.play()
