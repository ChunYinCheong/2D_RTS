extends "res://src/Abilities/Ability.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_effect(delta):
	if not command or disabled:
		return
	var target_unit = command["unit"]
	var target_position = command["position"]
	if target_unit:
		target_position = target_unit.global_position
		if unit.attack_cd <= 0:
			if (target_position - unit.global_position).length() > (unit.attack_range + target_unit.collision_size):
				unit.move(delta,target_position)
			else:
				if not target_unit.dead:
					unit.attack(target_unit)
				else:
					unit.command_end()
	else:		
		var attack_target
		for body in unit.active_attack_range.get_overlapping_bodies():
			if body.player_index != unit.player_index:
				if not body.dead:
					attack_target = body
		if attack_target:
			if unit.attack_cd <= 0:
				unit.attack(attack_target)
			# Else do nothing
		else:
			unit.move(delta,target_position)
		
		
