extends "res://src/Abilities/Ability.gd"

export var output = 1.0

func update_effect(delta):
	if not unit:
		return
	if unit.dead:
		return
	if delta == 0:
		return
	unit.power += output * delta
