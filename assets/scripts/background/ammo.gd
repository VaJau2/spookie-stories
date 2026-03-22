extends Area2D

@export var ammo_add_count: int = 6


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.get_node("revolver_controller").add_ammo(ammo_add_count)
		queue_free()
