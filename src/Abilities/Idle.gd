extends "res://src/Abilities/Ability.gd"

func update_effect(delta):
	if not command or disabled:
		return
	for body in unit.active_attack_range.get_overlapping_bodies():
		if body.player_index != unit.player_index:
			if unit.attack_cd <= 0:
				var target_unit = body
				if not target_unit.dead:
					unit.attack(target_unit)
