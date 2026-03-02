extends Button

@export var scenario_anim: AnimationPlayer
@export var main_menu_panel: Control


func _pressed() -> void:
	main_menu_panel.visible = false
	scenario_anim.play("idle")
