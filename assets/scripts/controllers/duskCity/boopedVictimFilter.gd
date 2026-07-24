extends Node

@export var parent: Node2D
@export var booped_state: StateBase


func filter(all_victims: Array[CharacterBody2D]) -> CharacterBody2D:
	if all_victims.is_empty(): return
	
	var filtered: Dictionary = _filter_booped(all_victims)
	
	if booped_state.is_booped:
		var not_booped_victim: CharacterBody2D = _filter_closest(filtered.not_booped)
		if not_booped_victim: return not_booped_victim
	
	return _filter_closest(filtered.booped)


func _filter_booped(all_victims: Array) -> Dictionary:
	var result: Dictionary = {"booped": [], "not_booped": []}
	
	for victim in all_victims:
		if victim.has_node("state_machine"):
			if victim.get_node("state_machine/booped").is_booped:
				result.booped.append(victim)
			else:
				result.not_booped.append(victim)
		elif victim.has_node("booped_state"):
			if victim.get_node("booped_state").is_booped:
				result.booped.append(victim)
			else:
				result.not_booped.append(victim)
	
	return result


func _filter_closest(victims: Array) -> CharacterBody2D:
	if victims.is_empty(): return null
	if len(victims) > 0: return victims[0]
	return null
	
	#var closest_victim = victims[0]
	#var closest_distance = parent.global_position.distance_to(victims[0].global_position)
	#for i in range(len(victims)):
		#if i == 0: continue
		#var temp_distance = parent.global_position.distance_to(victims[i].global_position)
		#if temp_distance < closest_distance:
			#closest_victim = victims[i]
			#closest_distance = temp_distance
	#
	#return closest_victim
