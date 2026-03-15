extends Area2D

@export var player_name: String
@export var scene_name: String
@onready var black_screen: ColorRect = get_node("/root/main/menu/black_screen")
@onready var catch_audi: AudioStreamPlayer2D = get_node("audi")

func _on_body_entered(body: Node2D) -> void:
	if body.name == player_name:
		set_process(true)
		catch_audi.play()


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	if black_screen.color.a < 1:
		black_screen.color.a += 3 * delta
	else:
		G.scene_vars.set("gas_station", 1)
		Scenes.goto_scene(scene_name)
