extends "res://src/Abilities/Ability.gd"

export var upgrade_ability_id : String = ""

export var ore_cost_fixed : int = 0
export var ore_cost_per_level : int = 0

export var crystal_cost_fixed : int = 0
export var crystal_cost_per_level : int = 0


func start(u,c):
	.start(u,c)
	for a in unit.abilities:
		if a.ability_id == upgrade_ability_id:
			var level = a.ability_level
			var ore = ore_cost_fixed + ore_cost_per_level * level
			var crystal = crystal_cost_fixed + crystal_cost_per_level * level
			for player in get_tree().get_nodes_in_group("Player"):
				if player.player_index == unit.player_index:
					if player.has_enough_resource(ore,crystal):
						player.consume_resource(ore,crystal)
						a.ability_level += 1
					else:
						ability_fail("Resource not enough")
						
	unit.command_end()
	pass
