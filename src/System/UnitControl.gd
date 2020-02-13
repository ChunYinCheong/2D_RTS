extends PanelContainer

const Unit = preload("res://src/Unit.gd")

var selected_unit : Unit
var selected_command


onready var unit_name_label = $HBoxContainer/VBoxContainer/NameLabel
onready var hp_label = $HBoxContainer/VBoxContainer/HpLabel
onready var attack_damage_label = $HBoxContainer/VBoxContainer/AttackDamageLabel
onready var attack_speed_label = $HBoxContainer/VBoxContainer/AttackSpeedLabel
onready var movement_speed_label = $HBoxContainer/VBoxContainer/MovementSpeedLabel
onready var action_label = $HBoxContainer/VBoxContainer/ActionLabel
onready var power_label = $HBoxContainer/VBoxContainer/PowerLabel

onready var ability_button_container = $HBoxContainer/GridContainer
onready var description_label = $HBoxContainer/DescriptionLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	for a in ability_button_container.get_children():
		a.connect("mouse_entered",self,"_on_AbilityButton_mouse_entered",[a])
		a.connect("mouse_exited",self,"_on_AbilityButton_mouse_exited",[a])
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hp_label.text = ""
	unit_name_label.text = ""
	attack_damage_label.text = ""
	attack_speed_label.text = ""
	movement_speed_label.text = ""
	action_label.text = ""
	power_label.text = ""
	for ac in ability_button_container.get_children():
		ac.ability = null
	
	if selected_unit and is_instance_valid(selected_unit):
		unit_name_label.text = "Name: " + selected_unit.name
		if not selected_unit is preload("res://src/Unit.gd"):
			return
		hp_label.text = "Hp: " + str(selected_unit.hp)
		attack_damage_label.text = "Attack Damage: " + str(selected_unit.attack_damage)
		attack_speed_label.text = "Attack Speed: " + str(selected_unit.attack_speed)
		movement_speed_label.text = "Movement Speed: " + str(selected_unit.movement_speed)
		action_label.text = "Action: " + str(selected_unit.current_command.ability_id if selected_unit.current_command != null else "")
		power_label.text = "Power: " + str(selected_unit.power)
		for ability in selected_unit.abilities:
			if ability.column >= ability_button_container.columns:
				continue
			if ability.row >= 3:
				continue
			var c = ability_button_container.get_child(ability.row * ability_button_container.columns + ability.column)
			c.ability = ability
	pass

func _on_AbilityButton_mouse_entered(ability_button):
	var a = ability_button.ability
	if a:	
		description_label.text = a.ability_name + "\n" +a.ability_description
	else:
		description_label.text = ""
	pass
func _on_AbilityButton_mouse_exited(ability_button):
	description_label.text = ""
	
