extends Node

signal attribute_changed

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
var command setget set_command
func set_command(c):
	command = c
	if command:
		start_effect()
		
onready var attributes = $Attributes

func start_effect():
	pass
	
func update_effect(delta):
	pass
