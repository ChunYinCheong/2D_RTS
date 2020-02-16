extends Node2D

export var player_index = 0
var player

onready var camera = $CameraSystem
onready var selection_system = $SelectionSystem

#var choosing_target = false
var preparing_ability


# Load the custom images for the mouse cursor.
var select = preload("res://assets/mouse_cursor/select.png")
var attack = preload("res://assets/mouse_cursor/attack.png")
var build = preload("res://icon.png")


onready var build_illusion = $BuildIllusion


var messages : Array = []


func _ready():
	for a in $PlayerCanvasLayer/UnitControl/HBoxContainer/GridContainer.get_children():
		a.connect("button_down",self,"_on_AbilityButton_button_down",[a])
	for p in get_tree().get_nodes_in_group("Player"):
		if p.player_index == player_index:
			player = p
			$PlayerCanvasLayer.player = p
			break
#	if is_network_master():
	camera.current = true

func _unhandled_input(event):
#	if not is_network_master():
#		return
	
	# Camera
	var m = 30
	if event.is_action("ui_down"):
		camera.position.y += m
	elif event.is_action("ui_up"):
		camera.position.y -= m
	elif event.is_action("ui_right"):
		camera.position.x += m
	elif event.is_action("ui_left"):
		camera.position.x -= m
	elif event.is_action_pressed("zoom_in"):
		camera.zoom /= 2
		if camera.zoom >= Vector2(10,10):
			camera.zoom = Vector2(10,10)
	elif event.is_action_pressed("zoom_out"):
		camera.zoom *= 2

	# Selection
	if event.is_action_pressed("left_click"):
		if preparing_ability:
			if build_illusion.visible:
				if not build_illusion.is_overlapping:
					selection_system.selected_unit.set_command({
						"ability_id": preparing_ability.action,
						"position": build_illusion.global_position,
						"unit": selection_system.pointing_unit,
						})
					stop_choosing_target()
			else:
				selection_system.selected_unit.set_command({
					"ability_id": preparing_ability.action,
					"position": get_global_mouse_position(),
					"unit": selection_system.pointing_unit,
					})
				stop_choosing_target()				
			return
		selection_system.selected_unit = selection_system.pointing_unit
			
	if event.is_action_pressed("right_click"):
		if preparing_ability:
			stop_choosing_target()
			return
		if selection_system.selected_unit:
			selection_system.selected_unit.right_click(get_global_mouse_position()
				,selection_system.pointing_unit)
			return
			
func _on_AbilityButton_button_down(control):
	print("_on_AbilityButton_button_down")
	var a = control.ability
	if not a:
		return
	if a.passive:
		return
	if a.need_target:
		preparing_ability = a
		Input.set_custom_mouse_cursor(attack,0,Vector2(32,32))
		if a is preload("res://src/Abilities/Build/Build.gd"):
			build_illusion.global_position = get_global_mouse_position()
			build_illusion.build_unit = a.building.instance()
			build_illusion.visible = true
		pass
	else:
		selection_system.selected_unit.set_command({"ability_id":a.ability_id})
#	print(control.ability)

func stop_choosing_target():
	Input.set_custom_mouse_cursor(null)
	preparing_ability = null
	build_illusion.visible = false
	if build_illusion.build_unit:
		build_illusion.build_unit.free()
		build_illusion.build_unit = null
	
