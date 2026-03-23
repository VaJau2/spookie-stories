extends DirectionalLight2D

@onready var player: Node2D = get_node("/root/main/player")

@export var target_color: Color
var start_color: Color


func reset_color() -> void:
	if !is_processing(): return
	color = start_color


func _ready() -> void:
	player.get_node("revolver_controller").shoot.connect(reset_color)
	start_color = color
	set_process(false)


func _process(delta: float) -> void:
	color = color.lerp(target_color, 0.05 * delta)
