extends StateBase

@export var anim: AnimationPlayer
@export var seek_area: CloseSeekArea

@export var sprites: Array[Sprite2D]
@export var booped_textures: Array[Texture2D]
@export var change_color_sprite: Sprite2D
@export var is_booped: bool = false
var old_color: Color



func enable() -> void:
	super.enable()
	anim.animation_finished.connect(_on_anim_finished)
	if movement_controller is MovementController:
		movement_controller.load_state("booped")


func disable() -> void:
	super.disable()
	if anim.animation_finished.is_connected(_on_anim_finished):
		anim.animation_finished.disconnect(_on_anim_finished)


func _on_anim_finished(anim_name: String) -> void:
	if anim_name != "booped": return
	
	if !is_booped:
		make_booped()
	
	var new_state: String = "idle"
	
	if seek_area:
		var victim = seek_area.get_victim()
		if victim != null:
			if victim.visible: new_state = "attack"
			else: new_state = "search"
	
	state_machine.enable_state(new_state)


func make_booped() -> void:
	is_booped = true
	seek_area.see_enemy_state = "attack"
	if change_color_sprite: change_color_sprite.modulate = Color.WHITE
	for i in range(len(sprites)):
		sprites[i].texture = booped_textures[i]
	movement_controller.get_node("walk").speed = randi_range(190, 220)
	movement_controller.get_node("run").speed = randi_range(330, 370)
