extends Button

@export var load_panel: Panel

func _ready() -> void:
	disabled = Save.data["level_num"] == 0


func _on_pressed() -> void:
	load_panel.visible = true
