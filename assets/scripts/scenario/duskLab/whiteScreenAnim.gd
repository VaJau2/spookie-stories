extends ColorRect

class_name WhiteScreenAnim

@export var start_delay_timer: float = 2
@export var show_delay_timer: float = 1.25
@export var color_speed_start: float = 3
@export var color_speed_end: float = 1.5

var is_show_screen: bool = true

signal screen_is_full


func _ready() -> void:
	set_process(false)


func start_anim() -> void:
	visible = true
	is_show_screen = true
	set_process(true)


func _process(delta: float) -> void:
	if start_delay_timer > 0:
		start_delay_timer -= delta
		return
	
	if is_show_screen:
		if color.a < 1:
			color.a += delta * color_speed_start
			return
		else:
			is_show_screen = false
			screen_is_full.emit()
	
	
	if show_delay_timer > 0:
		show_delay_timer -= delta * color_speed_end
		return
	
	if color.a > 0:
		color.a -= delta * 3
	else:
		set_process(false)
