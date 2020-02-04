extends Node

onready var attributes = $Attributes

func update_attributes(a):
	a.stack_attributes(attributes)
	pass