extends "res://src/Abilities/Ability.gd"

export var technology_id : String = ""

export var max_hp_per_level : float = 0 setget set_max_hp_per_level
func set_max_hp_per_level(value):
	if attribute_modifier:
		attribute_modifier.max_hp = value * technology_level
	max_hp_per_level = value

export var hp_regen_per_level : float = 0 setget set_hp_regen_per_level
func set_hp_regen_per_level(value):
	if attribute_modifier:
		attribute_modifier.hp_regen = value * technology_level
	hp_regen_per_level = value

export var max_mp_per_level : float = 0 setget set_max_mp_per_level
func set_max_mp_per_level(value):
	if attribute_modifier:
		attribute_modifier.max_mp = value * technology_level
	max_mp_per_level = value

export var mp_regen_per_level : float = 0 setget set_mp_regen_per_level
func set_mp_regen_per_level(value):
	if attribute_modifier:
		attribute_modifier.mp_regen = value * technology_level
	mp_regen_per_level = value

export var attack_damage_per_level : float = 0 setget set_attack_damage_per_level
func set_attack_damage_per_level(value):
	if attribute_modifier:
		attribute_modifier.attack_damage = value * technology_level
	attack_damage_per_level = value

export var attack_speed_per_level : float = 0 setget set_attack_speed_per_level
func set_attack_speed_per_level(value):
	if attribute_modifier:
		attribute_modifier.attack_speed = value * technology_level
	attack_speed_per_level = value

export var attack_range_per_level : float = 0 setget set_attack_range_per_level
func set_attack_range_per_level(value):
	if attribute_modifier:
		attribute_modifier.attack_range = value * technology_level
	attack_range_per_level = value

export var movement_speed_per_level : float = 0 setget set_movement_speed_per_level
func set_movement_speed_per_level(value):
	if attribute_modifier:
		attribute_modifier.movement_speed = value * technology_level
	movement_speed_per_level = value


onready var attribute_modifier = $Attributes
onready var player_technology_level = $PlayerTechnologyLevel
var technology_level

func _ready():
	player_technology_level.technology_id = self.technology_id
	
func _on_Unit_add_ability(unit):
	player_technology_level.player_index = unit.player_index
	unit.add_attribute_modifier(attribute_modifier)
	pass

func _on_Unit_remove_ability(unit):
	unit.remove_attribute_modifier(attribute_modifier)
	player_technology_level.player_index = 0
	pass


func _on_PlayerTechnologyLevel_technology_level_changed(new_value):
	technology_level = player_technology_level.technology_level
	attribute_modifier.max_hp = self.max_hp_per_level * self.technology_level
	attribute_modifier.hp_regen = self.hp_regen_per_level * self.technology_level
	attribute_modifier.max_mp = self.max_mp_per_level * self.technology_level
	attribute_modifier.mp_regen = self.mp_regen_per_level * self.technology_level
	attribute_modifier.attack_damage = self.attack_damage_per_level * self.technology_level
	attribute_modifier.attack_speed = self.attack_speed_per_level * self.technology_level
	attribute_modifier.attack_range = self.attack_range_per_level * self.technology_level
	attribute_modifier.movement_speed = self.movement_speed_per_level * self.technology_level
	attribute_modifier.emit_signal("changed")
	pass # Replace with function body.
