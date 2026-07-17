extends Sprite2D

@export var state_machine: StateMachine

func _ready() -> void:
	visible = false
	state_machine.state_changed.connect(_on_state_changed)


func _on_state_changed(new_state: String) -> void:
	match new_state:
		"idle":
			visible = false
		"attack":
			visible = true
			frame = 1
		"search":
			visible = true
			frame = 0
