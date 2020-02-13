extends Node

#const Technology = preload("res://src/Technology/Technology.gd")

signal technology_level_changed(technology)

var player_index setget ,get_player_index
func get_player_index():
	if is_inside_tree():
		return get_parent().player_index
	return 0
	
var technology_point = 0

#func _enter_tree():
#	player_index = get_parent().index
#	get_tree().call_group("TechnologyTreeListener", "_on_TechnologyTree_enter_tree", self)

func _ready():
	for tech in get_children():
		tech.connect("level_changed", self, "_on_Technology_level_changed", [tech])
		
func _on_Technology_level_changed(technology_level, technology):
	emit_signal("technology_level_changed", technology)
