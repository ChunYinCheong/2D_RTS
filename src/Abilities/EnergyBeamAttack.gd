extends "res://src/Abilities/Attack.gd"

export var power_consumption = 10.0

func update_effect(delta):		
	if not command or disabled:
		return
	var target_unit = command["unit"]
	var target_position = command["position"]
	if target_unit:
		target_position = target_unit.global_position
		if unit.attack_cd <= 0:
			if (target_position - unit.global_position).length() > unit.attack_range:
				unit.move(delta,target_position)
			else:
				if not target_unit.dead:					
					if unit.power < power_consumption:
						return
					unit.power -= power_consumption
					unit.attack(target_unit)
				else:
					unit.command_end()
	else:
		unit.move(delta,target_position)
