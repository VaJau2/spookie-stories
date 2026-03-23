extends Area2D

@onready var parent: CharacterBody2D = get_parent()
@onready var audi: AudioStreamPlayer2D = get_node("audi")

func _on_body_entered(body: Node2D) -> void:
	if parent.velocity.y < 200: return
	
	if body.has_node("stepped_controller"):
		var controller = body.get_node("stepped_controller")
		controller.stepped()
		audi.play()
