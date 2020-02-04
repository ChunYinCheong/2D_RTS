extends Area2D

var damage = 0
var from
var target_unit
var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_position = target_unit.global_position
	if (target_position - global_position).length() < speed * delta:
		target_unit.take_damage(damage,from)
		queue_free()
	else:
		global_position += (target_position - global_position).normalized() * speed * delta
	pass


func _on_Projectile_body_entered(body):
	if body == target_unit:
		target_unit.take_damage(damage,from)
		queue_free()
	pass # Replace with function body.
