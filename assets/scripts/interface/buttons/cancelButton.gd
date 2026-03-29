extends Button

@export var panel_to_close: Panel


func _on_pressed() -> void:
	panel_to_close.visible = false
