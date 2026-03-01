extends Sprite2D

class_name DialogueAvatar

const EYE_OPEN_TIME: float = 2.0
const BLINK_TIME: float = 0.1

var avatar_config: AvatarConfig

var is_blinking: bool
var timer: float

var temp_anim: DialogueAnimController


func load_avatar(character_name: String, state: String, anim: DialogueAnimController) -> void:
	var texture_file = load("res://assets/sprites/characters/dialogue/" + character_name + ".png")
	if texture_file:
		texture = texture_file
		avatar_config = AvatarConfig.new()
		avatar_config.load_from_file(character_name, state)
		frame = avatar_config.eyes_open
		visible = true
		if anim != null and temp_anim != anim:
			if temp_anim != null:
				temp_anim.blink.disconnect(_on_blink_emitted)
			anim.blink.connect(_on_blink_emitted)
			temp_anim = anim
		set_process(true)


func close_connections() -> void:
	if temp_anim:
		temp_anim.blink.disconnect(_on_blink_emitted)


func animate_mouth() -> void:
	timer = 0.05
	frame = avatar_config.mouth_open
	is_blinking = false


func _on_blink_emitted() -> void:
	timer = 0.05
	frame = avatar_config.eyes_closed
	is_blinking = true


func _ready() -> void:
	visible = false
	set_process(false)


func _process(delta: float) -> void:
	if !visible || texture == null: 
		set_process(false)
		return
	
	if timer > 0:
		timer -= delta
	else:
		frame = avatar_config.eyes_closed if is_blinking else avatar_config.eyes_open
		timer = BLINK_TIME if is_blinking else EYE_OPEN_TIME
		is_blinking = !is_blinking
