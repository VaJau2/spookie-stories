extends Light2D

@export var new_color: Color
@export var speed: float


func _ready() -> void:
	set_process(false)


func start() -> void:
	set_process(true)


func finish() -> void:
	color = new_color
	set_process(false)


func _process(delta: float) -> void:
	color = color.lerp(new_color, speed * delta)
