extends Button

@export var panel_to_close: Panel
@export var load_button: Button


func _on_pressed() -> void:
	panel_to_close.visible = false
	load_button.grab_focus()
