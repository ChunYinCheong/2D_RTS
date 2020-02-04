extends "res://src/Abilities/Ability.gd"

func update_effect(delta):
	if not command or disabled:
		return
	var target_position = command["position"]
	unit.move(delta,target_position)
	if (unit.global_position - target_position).length() <= 1:
		unit.command_end()
