extends TextureRect

@export var gamepad_texture: Texture2D
@export var keyboard_texture: Texture2D

@export var is_gamepad_texture: bool 


func _process(_delta: float) -> void:
	if !visible: return
	if is_gamepad_texture == Gamepad.is_gamepad: return 
	
	if Gamepad.is_gamepad:
		texture = gamepad_texture
	else:
		texture = keyboard_texture
	
	is_gamepad_texture = Gamepad.is_gamepad
