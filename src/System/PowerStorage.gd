extends Node

var player_index setget ,get_player_index
func get_player_index():
	var p = get_parent()
	if p is preload("res://src/Unit.gd"):
		return p.player_index
	return 0
	

export var power_storage = 0.0
export var max_power_storage = 0.0
export var recharge_speed = 0.0
