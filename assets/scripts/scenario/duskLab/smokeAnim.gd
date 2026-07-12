extends Control

class_name LabSmokeAnim

@onready var background: ColorRect = get_node("background")
@onready var smokes: Array[Node] = get_node("textures").get_children()

var current_alpha: float = 0
var alpha_target: float


func set_color_target(target: float) -> void:
	visible = true
	alpha_target = target
	set_process(true)


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	if abs(current_alpha - alpha_target) > 0.01: 
		current_alpha = lerp(current_alpha, alpha_target, delta)
		background.color.a = current_alpha
		for smoke: TextureRect in smokes:
			smoke.modulate.a = current_alpha
	else:
		set_process(false)
