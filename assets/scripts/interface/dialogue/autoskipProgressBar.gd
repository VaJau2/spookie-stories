extends ProgressBar

@onready var menu: DialogueMenu = get_parent()
@export var skip_label: Label

var may_show: bool = false
var local_timer: float = 0


func _ready() -> void:
	set_process(false)
	skip_label.visibility_changed.connect(_on_skip_visible)
	menu.started_dialogue.connect(_on_started_dialogue)
	menu.next_node.connect(_on_next_node)
	menu.finished_dialogue.connect(_on_finished_dialogue)


func _process(delta: float) -> void:
	local_timer += delta
	value = local_timer


func _on_skip_visible() -> void:
	if !may_show: return
	visible = skip_label.visible
	if visible: 
		set_process(true)
		_reset_value()


func _on_started_dialogue() -> void:
	may_show = menu.dialogue_skip


func _on_next_node() -> void:
	_reset_value()


func _on_finished_dialogue() -> void:
	visible = false
	set_process(false)


func _reset_value() -> void:
	local_timer = 0
	value = local_timer
	max_value = menu.node_skip_timer
