extends Area2D

@onready var cave_dir_light: DirectionalLight2D = get_node("/root/main/cave_dir_light")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		cave_dir_light.is_darking = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		cave_dir_light.is_darking = false
