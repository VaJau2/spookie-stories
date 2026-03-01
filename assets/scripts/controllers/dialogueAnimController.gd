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
	if anim.has_animation(new_state):
		state = new_state 
	else:
		state = "idle"
	
	anim.play(state)
	if new_talk_state != "" and anim.has_animation(talk_state):
		talk_state = new_talk_state
	else:
		talk_state = "talk"


func animate_mouth() -> void:
	anim.play(talk_state)
	await anim.animation_finished
	anim.play(state)


func emit_blink_signal() -> void:
	blink.emit()
