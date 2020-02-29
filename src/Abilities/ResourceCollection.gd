extends "res://src/Abilities/Ability.gd"

export var interval = 10.0
export var speed_basic = 1.0
export var speed_per_level = 0.0
export var ore_basic = 0
export var ore_per_level = 0
export var crystal_basic = 0
export var crystal_per_level = 0

var speed setget , get_speed
func get_speed():
	return speed_basic + speed_per_level * ability_level
var ore setget , get_ore
func get_ore():
	return ore_basic + ore_per_level * ability_level
var crystal setget , get_crystal
func get_crystal():
	return crystal_basic + crystal_per_level * ability_level
	
var progress = 0

func update_passive_effect(delta):
	progress += delta * self.speed
	if progress >= interval:
		progress -= interval
		if unit:
			for player in get_tree().get_nodes_in_group("Player"):
				if player.player_index == unit.player_index:
					player.ore += self.ore
					player.crystal += self.crystal
	pass
