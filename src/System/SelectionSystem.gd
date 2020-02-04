extends Node2D

var selection_area_list : Array = []
var selected

func _on_SelectionArea_mouse_entered(area):
	selection_area_list.append(area)
	pass
	
func _on_SelectionArea_mouse_exited(area):
	var i = selection_area_list.find(area)
	if i != -1:
		selection_area_list.remove(i)
	pass
