extends Node2D

onready var resource = $ResourceSystem
onready var technology = $TechnologySystem



#### Resource
var ore : int = 0 setget ,get_ore
func get_ore():
	return ore
	
var crystal : int = 0 setget ,get_crystal
func get_crystal():
	return crystal


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
	
	



export var index : int


#### Selectuib
var selection setget , get_selection
func get_selection():
	if selection_system.selected:
		return selection_system.selected.get_parent() 
	return  null

func get_selected_unit():
	if selection_system.selection_area_list.empty():
		return null
	return selection_system.selection_area_list.back().get_parent() 
#var choosing_target = false
var preparing_ability


# Load the custom images for the mouse cursor.
var select = preload("res://assets/mouse_cursor/select.png")
var attack = preload("res://assets/mouse_cursor/attack.png")
var build = preload("res://icon.png")

onready var selection_system = $SelectionSystem
onready var build_illusion = $BuildIllusion


var messages : Array = []

func _ready():
	for a in $CanvasLayer/UnitControl/HBoxContainer/GridContainer.get_children():
		a.connect("button_down",self,"_on_AbilityButton_button_down",[a])
		
func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		if preparing_ability:
			if build_illusion.visible:
				if not build_illusion.is_overlapping:
					get_selection().command({
						"action": preparing_ability.action,
						"position": build_illusion.global_position,
						"unit": get_selected_unit(),
						})
					stop_choosing_target()
			else:
				get_selection().command({
					"action": preparing_ability.action,
					"position": get_global_mouse_position(),
					"unit": get_selected_unit(),
					})
				stop_choosing_target()				
			return
		if not selection_system.selection_area_list.empty():
			selection_system.selected = selection_system.selection_area_list.back()
		else:
			selection_system.selected = null
			
	if event.is_action_pressed("right_click"):
		if preparing_ability:
			stop_choosing_target()
			return
		if get_selection():
			get_selection().right_click(get_global_mouse_position()
				,get_selected_unit())
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
		get_selection().command({"action":a.action})
#	print(control.ability)

func stop_choosing_target():
	Input.set_custom_mouse_cursor(null)
	preparing_ability = null
	build_illusion.visible = false
	if build_illusion.build_unit:
		build_illusion.build_unit.free()
		build_illusion.build_unit = null
	

func has_enough_resource(ore,crystal):
	if get_ore() < ore:
		return false
	if get_crystal() < crystal:
		return false
	return true

func consume_resource(ore,crystal):
	self.ore -= ore
	self.crystal -= crystal
	pass
	
func show_message(message):
	messages.append(message)
	pass
