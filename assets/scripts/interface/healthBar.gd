extends ProgressBar

@export var player: CharacterBody2D

var health_controller: HealthController


func _ready() -> void:
	health_controller = player.get_node("health_controller")
	health_controller.hitted.connect(on_player_health_changed)
	health_controller.healed.connect(on_player_health_changed)


func on_player_health_changed() -> void:
	value = health_controller.health
