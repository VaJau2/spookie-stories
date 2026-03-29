extends Button

@export var level_num: int

func _ready() -> void:
	if Save.data["level_num"] < level_num:
		queue_free()
		#disabled = true
		#text = Loc.trans("interface.load_menu.no_level")
	else:
		text = Loc.trans("interface.load_menu.levels." + name)


func _on_pressed() -> void:
	Scenes.goto_scene(name)
