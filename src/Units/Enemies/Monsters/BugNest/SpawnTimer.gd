extends Timer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SpawnTimer_timeout():
	var u = preload("res://src/Units/Enemies/Monsters/SmallBug/SmallBug.tscn").instance()
	u.player_index = get_parent().player_index
	get_tree().current_scene.add_child(u)
	u.global_position = get_parent().global_position
#	var p = get_parent().global_position
#	for n in get_tree().get_nodes_in_group("Unit"):
#		if n.player_index == 1:
#			p = n.global_position
#			break
	u.command({
		"action":"attack",		
		"unit":null,
		"position": Vector2(),
	})
	pass # Replace with function body.
