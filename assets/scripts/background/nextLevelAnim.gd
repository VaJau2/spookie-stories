extends Node

@export var black_screen: ColorRect


func start() -> void:
	set_process(true)


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	if black_screen.color.a < 1:
		black_screen.color.a += 3 * delta
	else:
		Scenes.goto_scene("shop")
