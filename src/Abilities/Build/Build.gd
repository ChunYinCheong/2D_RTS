extends "res://src/Abilities/Ability.gd"

export(PackedScene) var building :PackedScene
export var ore = 0
export var crystal = 0

func start_effect():
	var b = building.instance()

	var area = Area2D.new()
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = b.get_collision_shape()
	get_tree().current_scene.add_child(area)
	area.global_position = command.position
	
	if not area.get_overlapping_bodies().empty():
		show_fail_message("Overlapping!", command.position)
		area.queue_free()
		unit.command_end()
		return
	
	for player in get_tree().get_nodes_in_group("Player"):
		if player.index == unit.player_index:
			if not player.has_enough_resource(ore,crystal):
				show_fail_message("Resource not enough", command.position)
				area.queue_free()
				unit.command_end()
				return
			else:
				player.consume_resource(ore,crystal)
	b.player_index = unit.player_index
	get_tree().current_scene.add_child(b)
	b.global_position = command.position
	unit.command_end()
	pass
	
	
func show_fail_message(m,p):
	for player in get_tree().get_nodes_in_group("Player"):
		if player.index == unit.player_index:
			player.show_message(m)
	var label = preload("res://src/System/FadeOutLabel.tscn").instance()
	label.text = m
	get_tree().current_scene.add_child(label)
	label.rect_global_position = unit.global_position
	
