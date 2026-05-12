extends Button

@export var level_num: int

func _ready() -> void:
	G.lang_changed.connect(load_text)
	if Save.data["level_num"] < level_num:
		queue_free()
	else:
		load_text()


func _on_pressed() -> void:
	Scenes.goto_scene(name)


func load_text() -> void:
	text = Loc.trans("interface.load_menu.levels." + name)
