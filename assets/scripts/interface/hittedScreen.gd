extends TextureRect

@export var player: CharacterBody2D


func _ready() -> void:
	var health: HealthController = player.get_node("health_controller")
	health.hitted.connect(on_player_hitted)


func on_player_hitted() -> void:
	visible = true
	modulate.a = 1


func _process(delta: float) -> void:
	if !visible: return
	if modulate.a > 0:
		modulate.a -= delta
	else:
		visible = false
