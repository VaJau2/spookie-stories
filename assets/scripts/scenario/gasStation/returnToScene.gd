extends Node

@export var dialogue_menu: DialogueMenu
@export var dialogue_file: String
@export var dialogue_code: String
@export var start_timer: float = 0


func _process(delta: float) -> void:
	if start_timer > 0:
		start_timer -= delta
	else:
		if G.scene_vars.get("gas_station_lost_dialogue") == 1:
			start()
		else:
			dialogue_menu.start_dialogue(dialogue_file, dialogue_code)
		set_process(false)


func start() -> void:
	G.scene_vars.set("gas_station_lost_dialogue", 1)
	Scenes.goto_scene("gas_station")
