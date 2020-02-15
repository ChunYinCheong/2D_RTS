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


func _on_BugEvolutionTimer_timeout():
	for player in get_tree().get_nodes_in_group("Player"):
		if player.player_index == 2:
			for tech in player.technologies:
				if tech.technology_id == "bug_evolution":
					tech.technology_level += 1
	pass # Replace with function body.
