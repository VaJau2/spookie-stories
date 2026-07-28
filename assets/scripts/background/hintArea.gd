extends Area2D

@export var hint: HintLabel
@export var hint_code: String
@export var player_name: String
@export var save_variable: String


func _ready() -> void:
	if save_variable != "" && G.scene_vars.has(save_variable): 
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == player_name:
		if hint_code != "":
			hint.hint_key = hint_code
		hint.show_hint()
		if save_variable != "":
			G.scene_vars[save_variable] = 1
		queue_free()
