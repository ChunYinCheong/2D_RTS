extends "res://src/Abilities/Ability.gd"

var countdown = 5
var interval = 5
var power_consumption = 5.0

func update_effect(delta):
	if not unit:
		return
	if unit.dead:
		return
	if delta == 0:
		return
	var required = delta * power_consumption
	var available = min(unit.power, required)
	var e = available / required
	unit.power -= available
	countdown -= e * delta
	if countdown <= 0:
		countdown += interval
		for player in get_tree().get_nodes_in_group("Player"):
			if player.index == unit.player_index:
				player.ore += 1
	pass
