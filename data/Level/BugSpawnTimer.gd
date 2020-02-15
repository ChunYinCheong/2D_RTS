extends Timer


var count = 0

func _on_BugSpawnTimer_timeout():
	count += 10
	$Timer.start()
	pass # Replace with function body.


func _on_Timer_timeout():
	count -= 1
	if count <= 0:
		$Timer.stop()
	for n in get_tree().get_nodes_in_group("BugNest"):
		var u = preload("res://data/Units/Bugs/SmallBug/SmallBug.tscn").instance()
		u.player_index = n.player_index
		get_tree().current_scene.add_child(u)
		u.global_position = n.global_position
		u.set_command({
			"ability_id":"attack",		
			"unit":null,
			"position": Vector2(),
		})
	pass # Replace with function body.
