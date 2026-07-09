extends Node

@export var card_sprite: Node2D

@export var first_card_dialogue: DialogueArea
@export var second_card_dialogue: DialogueArea

@export var computer_dialogue_without_card: DialogueArea
@export var computer_dialogue_with_card_first: DialogueArea
@export var computer_dialogue_with_card_second: DialogueArea

@export var switch_sound: AudioStreamMP3
@export var access_denied_sound: AudioStreamMP3
@export var turn_off_sound: AudioStreamMP3

@export var computer_node: Node2D
@export var working_computer_audi: AudioStreamPlayer2D
var computer_sprite: Sprite2D
var computer_audi: AudioStreamPlayer2D

@export var denied_texture: Texture
@export var off_texture: Texture


func _ready() -> void:
	computer_audi = computer_node.get_node("audi")
	computer_sprite = computer_node.get_node("sprite")


func get_card_first() -> void:
	card_sprite.visible = false
	computer_dialogue_without_card.is_active = false
	computer_dialogue_with_card_first.is_active = true


func get_card_second() -> void:
	card_sprite.visible = false
	computer_dialogue_with_card_second.is_active = true


func computer_denied() -> void:
	computer_sprite.texture = denied_texture
	computer_audi.stream = access_denied_sound
	computer_audi.play()


func computer_off() -> void:
	working_computer_audi.stop()
	computer_sprite.texture = off_texture


func change_card_dialogue() -> void:
	if first_card_dialogue.is_active:
		first_card_dialogue.is_active = false
		second_card_dialogue.is_active = true


func sound_switch() -> void:
	computer_audi.stream = switch_sound
	computer_audi.play()


func sound_turn_off() -> void:
	computer_audi.stream = turn_off_sound
	computer_audi.play()
