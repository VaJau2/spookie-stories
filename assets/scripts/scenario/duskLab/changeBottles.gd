extends Node

@export_category("bottles")
@export var bottles: Array[Sprite2D]
@export var dialogues_to_disable: Array[Area2D]
@export var dialogues_to_enable: Array[Area2D]
@export var result: Sprite2D
@export var result_parts: Array[Vector2]

@export_category("result_anim")
@export var result_colored: Sprite2D
@export var shake_anim: AnimationPlayer
@export var result_audi: AudioStreamPlayer2D
@export var boiling_sound: AudioStreamMP3
@export var shake_sound: AudioStreamMP3
@export var explode_sound: AudioStreamMP3
@export var white_screen: WhiteScreenAnim
@export var result_broken: Sprite2D
@export var scientists: Array[CharacterBody2D]
@export var lab_smoke: LabSmokeAnim


func _ready() -> void:
	white_screen.screen_is_full.connect(_on_white_screen_full)


func take_first() -> void:
	bottles[0].visible = false
	if dialogues_to_disable[0]:
		dialogues_to_disable[0].is_active = false
	dialogues_to_enable[0].is_active = true


func change_first() -> void:
	result.region_rect = Rect2(result_parts[0], Vector2(16, 16))


func second_active() -> void:
	dialogues_to_enable[1].is_active = true


func take_second() -> void:
	bottles[1].visible = false
	dialogues_to_enable[2].is_active = true


func change_second() -> void:
	result.region_rect = Rect2(result_parts[1], Vector2(16, 16))


func third_active() -> void:
	dialogues_to_enable[3].is_active = true


func take_third() -> void:
	bottles[2].visible = false
	dialogues_to_enable[4].is_active = true


func change_third() -> void:
	result.region_rect = Rect2(result_parts[2], Vector2(16, 16))


func forth_active() -> void:
	dialogues_to_enable[5].is_active = true


func take_forth() -> void:
	bottles[3].visible = false
	dialogues_to_enable[6].is_active = true


func change_forth() -> void:
	result.region_rect = Rect2(result_parts[3], Vector2(16, 16))


func fifth_active() -> void:
	dialogues_to_enable[7].is_active = true


func take_fifth() -> void:
	bottles[4].visible = false
	dialogues_to_enable[8].is_active = true


func change_fifth() -> void:
	result.region_rect = Rect2(result_parts[4], Vector2(16, 16))


func sixth_active() -> void:
	dialogues_to_enable[9].is_active = true


func take_sixth() -> void:
	bottles[5].visible = false
	dialogues_to_enable[10].is_active = true


func change_sixth() -> void:
	result.region_rect = Rect2(result_parts[5], Vector2(16, 16))


func anim_color() -> void:
	result_colored.visible = true
	var anim = result_colored.get_node("anim")
	anim.play("color")
	result_audi.stream = boiling_sound
	result_audi.play()


func anim_shake() -> void:
	shake_anim.play("shake")
	result_audi.stream = shake_sound
	result_audi.play()


func anim_explode() -> void:
	make_scientists_go_to_flask()
	white_screen.start_anim()
	result_audi.stream = explode_sound
	result_audi.play()


func _on_white_screen_full() -> void:
	result.visible = false
	result_colored.visible = false
	var anim = result_colored.get_node("anim")
	anim.stop()
	shake_anim.stop()
	result_broken.visible = true
	var bubbles: GPUParticles2D = result_broken.get_node("bubbles")
	bubbles.emitting = true
	lab_smoke.set_color_target(0.2)


func anim_smoke1() -> void:
	lab_smoke.set_color_target(0.5)


func anim_smoke2() -> void:
	lab_smoke.set_color_target(0.95)


func make_scientists_go_to_flask() -> void:
	for scientist in scientists:
		var state_machine: StateMachine = scientist.get_node("state_machine")
		state_machine.enable_state("runToFlask")
