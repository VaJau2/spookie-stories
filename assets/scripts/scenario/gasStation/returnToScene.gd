extends Node

@export var dialogue_menu: DialogueMenu
@export var dialogue_file: String
@export var dialogue_code: String
@export var start_timer: float = 0
@export var scene_var: String = "gas_station_lost_dialogue"
@export var scene_name: String = "gas_station"


func _process(delta: float) -> void:
	if start_timer > 0:
		start_timer -= delta
	else:
		if G.scene_vars.get(scene_var) == 1:
			start()
		else:
			dialogue_menu.start_dialogue(dialogue_file, dialogue_code)
		set_process(false)


func start() -> void:
	Scenes.goto_scene(scene_name)
