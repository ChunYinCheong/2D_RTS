extends KinematicBody2D

const Player = preload("res://src/System/Player.gd")

signal die

var player : Player
export var player_index : int

var selected = false

var invincible = false
var dead = false

export var level = 1
export var hp = 1000
export var mp = 0
var attack_cd = 0

var command = {	"action": "hold" }
var velocity = Vector2()

onready var base_attributes = $UnitAttributes
onready var current_attributes = $CurrentAttributes

onready var upgrades = $Upgrades
onready var technology = $Technology

onready var active_attack_range = $AttackRange


var max_hp : float setget ,get_max_hp
func get_max_hp():
	return current_attributes.max_hp if current_attributes else 0.0
var hp_regen : float setget ,get_hp_regen
func get_hp_regen():
	return current_attributes.hp_regen if current_attributes else 0.0
var max_mp : float setget ,get_max_mp
func get_max_mp():
	return current_attributes.max_mp if current_attributes else 0.0
var mp_regen : float setget ,get_mp_regen
func get_mp_regen():
	return current_attributes.mp_regen if current_attributes else 0.0
var attack_damage : float setget ,get_attack_damage
func get_attack_damage():
	return current_attributes.attack_damage if current_attributes else 0.0
var attack_speed : float setget ,get_attack_speed
func get_attack_speed():
	return current_attributes.attack_speed if current_attributes else 0.0
var attack_range : float setget ,get_attack_range
func get_attack_range():
	return current_attributes.attack_range if current_attributes else 0.0
var movement_speed : float setget ,get_movement_speed
func get_movement_speed():
	return current_attributes.movement_speed if current_attributes else 0.0

var abilities : Array setget ,abilities_get
func abilities_get():
	return $Abilities.get_children()
var items : Array setget ,items_get
func items_get():
	return []
	
var collision_size : float setget ,get_collision_size
func get_collision_size():
	var shape = $CollisionShape2D.shape
	if shape is CircleShape2D:
		return shape.radius
	elif shape is RectangleShape2D:
		var e = shape.extents
		return e.x
export(Texture) var illusion_texture  = preload("res://icon.png")
func get_collision_shape():
	return $CollisionShape2D.shape

onready var power_storage = $PowerStorage
export var power = 0.0 setget set_power,get_power
func set_power(value):
	if power_storage:
		power_storage.power_storage = value
func get_power():
	if power_storage:
		return power_storage.power_storage
	return 0.0


func calculate_attributes():
	current_attributes.reset()
	current_attributes.stack_attributes(base_attributes)
	for a in self.abilities:
		a.unit = self
		if a.attributes:
			current_attributes.stack_attributes(a.attributes)
	
	pass
func _on_attributes_changed():
	calculate_attributes()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	calculate_attributes()
	for a in self.abilities:
		a.connect("attributes_changed",self, "_on_attributes_changed")
	command(command)
	var shape = CircleShape2D.new()
	shape.radius = self.attack_range
	$AttackRange/CollisionShape2D.shape = shape
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# update drawing
#	update()
	if dead:
		return
		
	
	hp += self.hp_regen * delta
	if hp > self.max_hp:
		hp = self.max_hp
		
	mp += self.mp_regen * delta
	if mp > self.max_mp:
		mp = self.max_mp
	
	if attack_cd > 0:
		attack_cd -= current_attributes.attack_speed * delta
	pass

func _physics_process(delta):
	for a in abilities_get():
		a.update_effect(delta)	
	return


func right_click(p,u):
	if u and u.player_index != player_index:
		command({
		"action":"attack",
		"unit":u,
		"position":p,
	})
	else:
		command({
		"action":"move",
		"unit":u,
		"position":p,
	})
	
func command(c):
	if dead:
		return
	if command:
		for a in abilities_get():
			if a.action == command["action"]:
				a.command = null
	command = c
	if command:
		for a in abilities_get():
			if a.action == command["action"]:
				a.command = command

func command_end():
	command({"action":"hold"})
	pass

func move(delta, target_position):
	var dir = (target_position - global_position).normalized()
	var dis = (target_position - global_position).length()
	var speed = self.movement_speed
	if delta > 0:
		speed = min(speed, dis/delta)
	velocity = dir * speed
	velocity = move_and_slide(velocity)
	pass
func attack(target_unit):
	var projectile = preload("res://src/Projectile.tscn").instance()
	projectile.from = self
	projectile.damage = self.attack_damage
	projectile.target_unit = target_unit
	projectile.speed = 500
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	attack_cd = 1
	
func take_damage(damage,from):
	hp -= damage
	if hp <= 0:
		kill(from)
		
func kill(from):
	command_end()
	dead = true
	collision_layer = 0
	collision_mask = 0
#	modulate = Color(1, 1, 1, 0.25)
	$SelectionArea.monitorable = false
	$SelectionArea.monitoring = false
	var t = Tween.new()
	t.interpolate_property(self, "modulate"
	,Color.white, Color(0,0,0,0), 10.0
	,Tween.TRANS_LINEAR, Tween.EASE_IN)
	add_child(t)
	t.start()
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout",self,"queue_free")
	timer.start(10.0)
	emit_signal("die")
	pass
	


func _draw():
	var shape = $CollisionShape2D.shape
	var color = Color(1,1,1,0.25)
	if player_index == 1:
		if selected:
			color = Color(0,1,0,0.25)
		else:
			color = Color(0,0,1,0.25)
	else:
		color = Color(1,0,0,0.25)
	if shape is CircleShape2D:
		var r = shape.radius
		draw_circle(Vector2(),r,color)
	elif shape is RectangleShape2D:
		var e = shape.extents
		var width = e.x
		var height = e.y
		draw_rect(Rect2(-e, e*2),color,true)
	else:
		push_error("Not supported shape in Unit _draw")
	
#func save():
#    var save_dict = {
#        "filename" : get_filename(),
#        "parent" : get_parent().get_path(),
#        "pos_x" : position.x, # Vector2 is not supported by JSON
#        "pos_y" : position.y,
#        "attack" : attack,
#        "defense" : defense,
#        "current_health" : current_health,
#        "max_health" : max_health,
#        "damage" : damage,
#        "regen" : regen,
#        "experience" : experience,
#        "tnl" : tnl,
#        "level" : level,
#        "attack_growth" : attack_growth,
#        "defense_growth" : defense_growth,
#        "health_growth" : health_growth,
#        "is_alive" : is_alive,
#        "last_attack" : last_attack
#    }
#    return save_dict
