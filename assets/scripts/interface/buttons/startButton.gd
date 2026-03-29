extends Button

@export var scenario_anim: AnimationPlayer
@export var main_menu_panel: Control
@export var pause_menu: PauseMenu


func _pressed() -> void:
	G.scene_vars.clear()
	main_menu_panel.visible = false
	pause_menu.may_pause = true
	scenario_anim.play("idle")
