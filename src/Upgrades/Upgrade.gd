extends Node

var upgrade_name : String = ""
var upgrade_description : String = ""

var upgrade_ore = 0
var upgrade_crystal = 0

var upgrade_level : int = 0

onready var attributes = $Attributes

func upgrade():
	upgrade_level += 1
	pass
	
func update_attributes(a):
	a.stack_attributes(attributes)
	pass