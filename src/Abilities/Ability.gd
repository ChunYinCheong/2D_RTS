extends Node

signal attribute_changed

export var ability_id : String = ""
export var ability_name : String = ""
export var ability_description : String = ""
export var ability_level : int = 0 setget set_ability_level
func set_ability_level(value):
	ability_level = value
export var max_level : int = 0

export var hotkey : String = ""
export var row : int = 0
export var column : int = 0
export var texture = preload("res://assets/mouse_cursor/attack.png")

#export var action :String = ""
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

func update_passive_effect(delta):
	pass

func _on_Unit_add_ability(unit):
	self.unit = unit
	pass

func _on_Unit_remove_ability(unit):
	self.unit = null
	pass



func ability_fail(m):
	for player in get_tree().get_nodes_in_group("Player"):
		if player.player_index == unit.player_index:
			player.show_message(m)
	var label = preload("res://src/System/FadeOutLabel.tscn").instance()
	label.text = m
	get_tree().current_scene.add_child(label)
	label.rect_global_position = unit.global_position
	pass
