extends Node

@export var bed_sprite: Sprite2D

@export var bed_textures: Dictionary[String, Texture2D] = {
	"empty": null,
	"closed_eyes": null,
	"open_eyes": null,
	"open_eyes_2": null
}

@export var player: CharacterBody2D
@export var black_screen: ColorRect

@export var directional_light: DirectionalLight2D
@export var night_color: Color

@export var clock_audi: AudioStreamPlayer2D
@export var clock_night_sound: AudioStream

@export var outside_audi: AudioStreamPlayer2D
@export var outside_night_sound: AudioStream

@export var get_up_point: Node2D
@export var night_dialogue_area: DialogueArea

@export var dialogue_menu: DialogueMenu


func start() -> void:
	var movement: MovementController = player.get_node("movement_controller")
	movement.may_move = false
	player.visible = false
	bed_sprite.texture = bed_textures.closed_eyes


func anim_black_screen() -> void:
	while black_screen.color.a < 1:
		black_screen.color.a += 0.1
		await get_tree().process_frame
	
	await get_tree().create_timer(1).timeout
	change_to_night()
	
	while black_screen.color.a > 0:
		black_screen.color.a -= 0.1
		await get_tree().process_frame
	
	await get_tree().create_timer(0.5).timeout
	
	dialogue_menu.start_dialogue("strikely_home", "failed_to_sleep")


func change_to_night() -> void:
	directional_light.color = night_color
	clock_audi.stream = clock_night_sound
	clock_audi.play()
	outside_audi.stream = outside_night_sound
	outside_audi.play()


func set_open_eyes_texture() -> void:
	bed_sprite.texture = bed_textures.open_eyes


func set_open_eyes_texture_2() -> void:
	bed_sprite.texture = bed_textures.open_eyes_2


func get_up() -> void:
	var movement: MovementController = player.get_node("movement_controller")
	movement.may_move = true
	player.global_position = get_up_point.global_position
	player.visible = true
	bed_sprite.texture = bed_textures.empty
	night_dialogue_area.is_active = true
