extends Button

@export var level_num: int
@export var clear_save_variables: Array[String]

func _ready() -> void:
	G.lang_changed.connect(load_text)
	if Save.data["level_num"] < level_num:
		queue_free()
	else:
		load_text()


func _on_pressed() -> void:
	for clear_variable: String in clear_save_variables:
		Save.data.erase(clear_variable)
		G.scene_vars.erase(clear_variable)
	Scenes.goto_scene(name)


func load_text() -> void:
	text = Loc.trans("interface.load_menu.levels." + name)
