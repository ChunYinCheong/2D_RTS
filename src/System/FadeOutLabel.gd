extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var duration = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self, "modulate"
	,Color.white, Color(0,0,0,0), duration
	,Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
