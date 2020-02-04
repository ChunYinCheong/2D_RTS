extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	var m = 30
	if event.is_action("ui_down"):
		position.y += m
	elif event.is_action("ui_up"):
		position.y -= m
	elif event.is_action("ui_right"):
		position.x += m
	elif event.is_action("ui_left"):
		position.x -= m
	elif event.is_action_pressed("zoom_in"):
		zoom /= 2
		if zoom >= Vector2(10,10):
			zoom = Vector2(10,10)
	elif event.is_action_pressed("zoom_out"):
		zoom *= 2