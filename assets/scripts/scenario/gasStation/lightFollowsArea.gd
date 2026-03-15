extends Area2D

@export var player_name: String
@export var light: Light2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == player_name:
		light.set_player(body)


func _on_body_exited(body: Node2D) -> void:
	if body.name == player_name:
		light.clear_player()
