extends Node

signal attribute_changed

export var ability_id : String = ""
export var ability_name : String = ""
export var ability_description : String = ""
export var ability_level : int = 0
export var max_level : int = 0

export var hotkey : String = ""
export var row : int = 0
export var column : int = 0
export var texture = preload("res://assets/mouse_cursor/attack.png")

export var action :String = ""
export var need_target = false

export var disabled = false
export var passive = false


var unit
var command 
		
func start(u, c):
	unit = u
	command = c
	pass
	
func stop():
	pass

func start_effect():
	pass
	
func update_effect(delta):
	pass

func _on_Unit_add_ability(unit):
	pass

func _on_Unit_remove_ability(unit):
	pass
