extends DirectionalLight2D

@onready var player: Node2D = get_node("/root/main/player")

@export var light_color: Color
var dark_color: Color

var is_darking: bool


func darken_color() -> void:
	if !is_processing(): return
	color = dark_color


func _ready() -> void:
	player.get_node("revolver_controller").shoot.connect(darken_color)
	dark_color = color
	set_process(false)


func _process(delta: float) -> void:
	if is_darking:
		color = color.lerp(dark_color, 0.5 * delta)
	else:
		color = color.lerp(light_color, 0.05 * delta)
