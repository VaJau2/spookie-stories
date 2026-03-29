extends Node

@export var black_screen: ColorRect
@export var next_level: String

@export var save_level_num: int


func start() -> void:
	set_process(true)


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	if black_screen.color.a < 1:
		black_screen.color.a += 3 * delta
	else:
		if save_level_num > 0:
			if Save.data["level_num"] < save_level_num:
				Save.data["level_num"] = save_level_num
		Scenes.goto_scene(next_level)
