extends ProgressBar

@export var player: CharacterBody2D

var health_controller: HealthController


func _ready() -> void:
	health_controller = player.get_node("health_controller")
	health_controller.hitted.connect(on_player_hitted)


func on_player_hitted() -> void:
	value = health_controller.health
