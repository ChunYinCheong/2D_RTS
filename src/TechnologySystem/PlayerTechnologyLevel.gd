extends Node

signal technology_level_changed(new_value)

const TechnologyTree = preload("res://src/TechnologySystem/TechnologyTree.gd")
const Technology = preload("res://src/TechnologySystem/Technology.gd")

export var technology_id: String = "" setget set_technology_id
func set_technology_id(value):
	clean_up()
	technology_id = value
	set_up()
	emit_signal("technology_level_changed", technology_level)
	pass
	
export var player_index = 0 setget set_player_index
func set_player_index(value):
	clean_up()
	player_index = value
	set_up()
	emit_signal("technology_level_changed", technology_level)
	pass
	
var technology_level# setget ,get_technology_level
#func get_technology_level():
#	if is_inside_tree() and player_index != 0 and technology_id != "":
#		for tech in get_tree().get_nodes_in_group("Technology"):
#			if tech.technology_id != self.technology_id:
#				continue
#			if tech.player_index != self.player_index:
#				continue
#			return tech.technology_level
#	return 0
	
func _enter_tree():
	set_up()
	pass
	
	
func _exit_tree():
	clean_up()
	pass

func set_up():
	if player_index != 0 and technology_id != "":
		for p in get_tree().get_nodes_in_group("Player"):
			if p.player_index == self.player_index:
				p.connect("technology_level_changed", self, "_on_Player_technology_level_changed")
				for tech in p.technologies:
					if tech.technology_id == self.technology_id:
						technology_level = tech.technology_level
						break
				break
	pass

func clean_up():
	if player_index != 0 and technology_id != "":
		for p in get_tree().get_nodes_in_group("Player"):
			if p.player_index == self.player_index:
				p.disconnect("technology_level_changed", self, "_on_Player_technology_level_changed")
#				for tech in p.technologies:
#					if tech.technology_id != self.technology_id:
#						technology_level = tech.technology_level
#						break
				break
	technology_level = 0
	pass
	
func _on_Player_technology_level_changed(technology):
	if technology.technology_id != self.technology_id:
		return
	technology_level = technology.technology_level
	emit_signal("technology_level_changed", technology_level)
	pass
