extends Node

signal level_changed(new_value)

export var technology_id : String = ""
export var technology_name : String = ""
export var technology_description : String = ""
export var technology_level : int = 0 setget set_technology_level
func set_technology_level(value):
	technology_level = value
	emit_signal("level_changed", technology_level)
export var max_level : int = 0


var player_index setget ,get_player_index
func get_player_index():
	if is_inside_tree():
		return get_parent().player_index
	return 0
	
