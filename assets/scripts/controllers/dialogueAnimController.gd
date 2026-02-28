extends Node

#--------------------------------------------------------
# Анимирует говорящего и моргающего персонажа у костра во время диалогов
#--------------------------------------------------------

class_name DialogueAnimController

@export var anim: AnimationPlayer
@export var state: String = "idle"
@export var talk_state: String = "talk"

signal blink


func set_state(new_state: String, new_talk_state: String = "") -> void:
	state = new_state
	if new_talk_state != "":
		talk_state = new_talk_state


func animate_mouth() -> void:
	anim.play(talk_state)
	await anim.animation_finished
	anim.play(state)


func emit_blink_signal() -> void:
	blink.emit()
