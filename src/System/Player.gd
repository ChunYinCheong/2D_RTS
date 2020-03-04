extends Node


signal technology_level_changed(technology)

onready var technology_tree = $TechnologyTree
var technologies setget ,get_technologies
func get_technologies():
	if is_inside_tree():
		return technology_tree.get_children()
	return []
#### Resource
var ore : int = 0	
var crystal : int = 0

#### Power
onready var power_system = $PowerSystem

var power_supply setget ,get_power_supply
func get_power_supply():
	if power_system:
		return power_system.power_supply
	return 0.0
	
var power_recharge_speed  setget ,get_power_recharge_speed
func get_power_recharge_speed():
	if power_system:
		return power_system.recharge_speed
	return 0.0
	
var power_availability setget ,get_power_availability
func get_power_availability():
	if power_system:
		return power_system.availability
	return 0.0
	
var power_consumption setget ,get_power_consumption
func get_power_consumption():
	if power_system:
		return power_system.power_consumption
	return 0.0

export var player_index : int

var messages : Array = []


func has_enough_resource(ore,crystal):
	if self.ore < ore:
		return false
	if self.crystal < crystal:
		return false
	return true

func consume_resource(ore,crystal):
	self.ore -= ore
	self.crystal -= crystal
	pass
	
func show_message(message):
	messages.append(message)
	pass


func _on_TechnologyTree_technology_level_changed(technology):
	emit_signal("technology_level_changed", technology)
	pass # Replace with function body.
