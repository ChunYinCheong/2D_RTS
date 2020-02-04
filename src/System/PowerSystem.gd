extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = $".."

var power_supply = 0.0 setget ,get_power_supply
func get_power_supply():
	var power_supply = 0.0
	for supply in get_tree().get_nodes_in_group("PowerSupply"):
		if supply.player_index == player.index:
			power_supply += supply.power
	return power_supply
	
var recharge_speed = 0.0 setget ,get_recharge_speed
func get_recharge_speed():
	var recharge_speed = 0.0
	for storage in get_tree().get_nodes_in_group("PowerStorage"):
		if storage.player_index == player.index:
			recharge_speed += storage.recharge_speed
	return recharge_speed

var availability = 0.0
var power_consumption = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delta == 0:
		return
	var availability = self.power_supply 
	var power_consumption = 0.0
	var power = self.power_supply * delta
	for storage in get_tree().get_nodes_in_group("PowerStorage"):
		if storage.player_index == player.index:
			var r = min(storage.recharge_speed * delta, (storage.max_power_storage - storage.power_storage))
			var fill = min(r,power)
			power_consumption += r / delta
			availability -= min(storage.recharge_speed, (storage.max_power_storage - storage.power_storage))
			power -= fill
			storage.power_storage += fill
	self.availability = availability
#	if delta > 0:
#		power_consumption /= delta
	self.power_consumption = power_consumption
	pass
