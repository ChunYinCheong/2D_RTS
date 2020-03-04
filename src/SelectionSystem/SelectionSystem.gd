extends Node

signal selected_unit_changed(unit)

var selection_area_list : Array = []

var selected_unit setget set_selected_unit
func set_selected_unit(value):
	selected_unit = value
	emit_signal("selected_unit_changed", value)
	
var pointing_unit setget ,get_pointing_unit
func get_pointing_unit():
	if selection_area_list.empty():
		return null
	var n = selection_area_list.back()
	if is_instance_valid(n):
		return n.get_parent()
	else:
		pass
	return 

func _on_SelectionArea_mouse_entered(area):
	selection_area_list.append(area)
	pass
	
func _on_SelectionArea_mouse_exited(area):
	var i = selection_area_list.find(area)
	if i != -1:
		selection_area_list.remove(i)
	pass
