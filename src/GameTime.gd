extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var second = 0
var minute = 0
var hour = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	second += delta
	if second >= 60:
		second -= 60
		minute += 1
		if minute >= 60:
			minute -= 60
			hour += 1
	pass

func _unhandled_input(event):
	if event.is_action_pressed("speed_up"):
		Engine.time_scale *= 2
	if event.is_action_pressed("speed_down"):
		Engine.time_scale *= 0.5
	if event.is_action_pressed("speed_reset"):
		Engine.time_scale = 1
	if event.is_action_pressed("speed_pause"):
		Engine.time_scale = 0
	
	
