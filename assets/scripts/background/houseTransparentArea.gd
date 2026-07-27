extends Area2D

@export var sprite: Sprite2D
@export var player_name: String


func _on_body_entered(body: Node2D) -> void:
	if body.name == player_name:
		sprite.modulate.a = 0.5


func _on_body_exited(body: Node2D) -> void:
	if body.name == player_name:
		sprite.modulate.a = 1
