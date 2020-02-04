extends Sprite

var build_unit setget set_build_unit
func set_build_unit(v):
	build_unit = v
	if build_unit:
		collision_size = Vector2(build_unit.collision_size, build_unit.collision_size) * 2
		standardized_collision_size = (collision_size / grid_size).ceil() * 64
		texture = build_unit.illusion_texture
		$Area2D/CollisionShape2D.shape.extents = collision_size / 2
#	update()
	
var is_overlapping setget ,get_is_overlapping
func get_is_overlapping():
	return not $Area2D.get_overlapping_bodies().empty()
var collision_size
var standardized_collision_size
var grid_size = 64


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		var top_left = ((get_global_mouse_position() - (standardized_collision_size / 2)) / grid_size).round() * grid_size
		var p = top_left + (standardized_collision_size / 2)
		global_position = p
		pass
	pass
	
func _draw():
	if visible:
		var color = Color(0,1,0,0.25)
		if get_is_overlapping():
			color = Color(1,0,0,0.25)
		draw_rect(
			Rect2(-(standardized_collision_size/2), standardized_collision_size),
			color,true)

func _on_Area2D_body_entered(body):
	update()
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	update()
	pass # Replace with function body.
