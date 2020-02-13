extends CanvasLayer

var player_controller
var player setget set_player
func set_player(value):
	player = value
	$ResourceControl.player = value
var unit


func _on_SelectionSystem_selected_unit_changed(unit):
	self.unit = unit
	$UnitControl.selected_unit = unit
	pass # Replace with function body.
