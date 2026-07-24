extends StateBase

@export var stun_anim: Sprite2D
@export var pie: Sprite2D
@export var pie_textures: Array[Texture2D]
@export var seek_area: CloseSeekArea

var stun_timer: float
const STUN_TIME: float = 8


func enable() -> void:
	super.enable()
	stun_timer = STUN_TIME
	
	if movement_controller is MovementController:
		if randf() < 0.5:
			pie.texture = pie_textures[0]
			movement_controller.load_state("pied")
		else:
			pie.texture = pie_textures[1]
			movement_controller.load_state("pied2")
	
	stun_anim.visible = true
	pie.visible = true


func disable() -> void:
	super.disable()
	pie.visible = false
	stun_anim.visible = false


func _process(delta: float) -> void:
	if stun_timer > 0:
		stun_timer -= delta
	else:
		var new_state: String = "idle"
		
		if seek_area:
			var victim = seek_area.get_victim()
			if victim:
				if victim.visible: new_state = "attack"
				else: new_state = "search"
		
		state_machine.enable_state(new_state)
