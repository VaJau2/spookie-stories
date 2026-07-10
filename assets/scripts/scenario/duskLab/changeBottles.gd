extends Node

@export var bottles: Array[Sprite2D]
@export var dialogues_to_disable: Array[Area2D]
@export var dialogues_to_enable: Array[Area2D]
@export var result: Sprite2D
@export var result_parts: Array[Vector2]


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
