extends Label

@export var ponies_parent: Node2D
@export var final_dialogue: Node

var count_healed: bool = true
var count: int


func start_count() -> void:
	visible = true
	_count_ponies()


func set_booped() -> void:
	count_healed = false
	_count_ponies()


func _update_counter() -> void:
	_count_ponies()


func _count_ponies() -> void:
	count = 0
	
	for pony in ponies_parent.get_children():
		if pony.has_node("state_machine"):
			var booped_state: BoopedState = pony.get_node("state_machine/booped")
			if !booped_state: continue
			
			if !booped_state.booped_changed.is_connected(_update_counter):
				booped_state.booped_changed.connect(_update_counter)
			
			if count_healed:
				if booped_state.is_booped: count += 1
			else:
				if !booped_state.is_booped: count += 1
	
	if count == 0:
		visible = false
		final_dialogue.play_final_dialogue(count_healed)
	else:
		_show_count()


func _show_count() -> void:
	var code = "healed" if count_healed else "booped"
	text = Loc.trans("interface.ponies_counter." + code) + str(count)
