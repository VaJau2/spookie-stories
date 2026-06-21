extends Node

@export_category("Before")
@export var mother: CharacterBody2D

@export var door_audi: AudioStreamPlayer2D
@export var door_sound: AudioStream

@export var player: CharacterBody2D
@export var black_screen: ColorRect
@export var middle_room_point: Node2D
@export var strikely_and_mother: Node2D
@export var strikely_room: Node2D

@export var dialogue_menu: DialogueMenu

@export_category("After")
@export var strikely_door_audi: AudioStreamPlayer2D
@export var steps_wood_away_sound: AudioStream

@export var get_up_point: Node2D
@export var get_up_point2: Node2D
@export var clock_audi: AudioStreamPlayer2D
@export var scary_clock_sound: AudioStream

@export var kitchen_spawner: Node2D
@export var outside_dialogue_area: DialogueArea


func show_mother() -> void:
	var player_anim: AnimationController = player.get_node("animation_controller")
	if player_anim.sprites[0].flip_h:
		player_anim.set_flip(false)
	door_audi.stream = door_sound
	door_audi.play()
	mother.visible = true


func anim_black_screen() -> void:
	while black_screen.color.a < 1:
		black_screen.color.a += 0.1
		await get_tree().process_frame
	
	move_back_to_room()
	await get_tree().create_timer(0.5).timeout
	
	while black_screen.color.a > 0:
		black_screen.color.a -= 0.1
		await get_tree().process_frame
	
	await get_tree().create_timer(0.5).timeout
	
	dialogue_menu.start_dialogue("strikely_home", "night2")


func move_back_to_room() -> void:
	strikely_room.visible = true
	player.global_position = middle_room_point.global_position
	set_may_move(false)
	player.visible = false
	strikely_and_mother.visible = true
	var anim: AnimationPlayer = strikely_and_mother.get_node("anim")
	anim.play("shake-strong")


func shake_middle() -> void:
	var anim: AnimationPlayer = strikely_and_mother.get_node("anim")
	anim.play("shake-middle")
	var sprite: Sprite2D = strikely_and_mother.get_node("sprite")
	sprite.frame = 1


func shake_middle2() -> void:
	var sprite: Sprite2D = strikely_and_mother.get_node("sprite")
	sprite.frame = 2


func shake_low() -> void:
	var anim: AnimationPlayer = strikely_and_mother.get_node("anim")
	anim.play("shake-low")
	var sprite: Sprite2D = strikely_and_mother.get_node("sprite")
	sprite.frame = 3


func shake_strong() -> void:
	var anim: AnimationPlayer = strikely_and_mother.get_node("anim")
	anim.play("shake-strong")
	var sprite: Sprite2D = strikely_and_mother.get_node("sprite")
	sprite.frame = 0


func anim_black_screen_2() -> void:
	while black_screen.color.a < 1:
		black_screen.color.a += 0.1
		await get_tree().process_frame
	
	shake_low()
	await get_tree().create_timer(0.5).timeout
	
	while black_screen.color.a > 0:
		black_screen.color.a -= 0.1
		await get_tree().process_frame
	
	await get_tree().create_timer(0.5).timeout
	
	strikely_door_audi.stream = steps_wood_away_sound
	strikely_door_audi.play()
	dialogue_menu.start_dialogue("strikely_home", "night3")


func get_up() -> void:
	clock_audi.stream = scary_clock_sound
	clock_audi.play()
	player.global_position = get_up_point.global_position
	mother.global_position = get_up_point2.global_position
	mother.visible = true
	mother.get_node("sprite").flip_h = false
	var player_anim: AnimationController = player.get_node("animation_controller")
	player_anim.set_flip(true)
	player.visible = true
	strikely_and_mother.visible = false
	kitchen_spawner.spawn()
	outside_dialogue_area.is_active = true


func set_may_move(value: bool = true) -> void:
	var movement: MovementController = player.get_node("movement_controller")
	movement.may_move = value
