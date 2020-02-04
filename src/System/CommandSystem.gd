extends Node2D

# Load the custom images for the mouse cursor.
var select = preload("res://assets/mouse_cursor/select.png")
var attack = preload("res://assets/mouse_cursor/attack.png")
var build = preload("res://icon.png")

var command

onready var selection_system = $"../SelectionSystem"

func _process(delta):
	if command:
		if command.action == "attack":
			Input.set_custom_mouse_cursor(attack,0,Vector2(32,32))
		elif command.action == "build":
			Input.set_custom_mouse_cursor(build,0,Vector2(32,32))			
		else:
			Input.set_custom_mouse_cursor(select,0,Vector2(32,32))
	else:
		Input.set_custom_mouse_cursor(select,0,Vector2(32,32))
		
	
func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		if not selection_system.selection_area_list.empty():
			selection_system.selected = selection_system.selection_area_list.back()
		return
	if event.is_action_pressed("right_click"):
		if selection_system.selected:
			selection_system.selected.right_click(get_global_mouse_position(), selection_system.selection_area_list.back())
	