extends Node

export var max_hp : float = 0
export var hp_regen : float = 0
export var max_mp : float = 0
export var mp_regen : float = 0
export var attack_damage : float = 0
export var attack_speed : float = 0
export var attack_range : float = 0
export var movement_speed : float = 0

#var max_hp_multiplier : float = 1.0
#var hp_regen_multiplier : float = 1.0
#var max_mp_multiplier : float = 1.0
#var mp_regen_multiplier : float = 1.0
#var attack_damage_multiplier : float = 1.0
#var attack_speed_multiplier : float = 1.0
#var attack_range_multiplier : float = 1.0
#var movement_speed_multiplier : float = 1.0


func stack_attributes(attributes):
	max_hp += attributes.max_hp
	hp_regen += attributes.hp_regen
	max_mp += attributes.max_mp
	mp_regen += attributes.mp_regen
	attack_damage += attributes.attack_damage
	attack_speed += attributes.attack_speed
	attack_range += attributes.attack_range
	movement_speed += attributes.movement_speed
	
#	max_hp_multiplier *= attributes.max_hp_multiplier
#	hp_regen_multiplier *= attributes.hp_regen_multiplier
#	max_mp_multiplier *= attributes.max_mp_multiplier
#	mp_regen_multiplier *= attributes.mp_regen_multiplier
#	attack_damage_multiplier *= attributes.attack_damage_multiplier
#	attack_speed_multiplier *= attributes.attack_speed_multiplier
#	attack_range_multiplier *= attributes.attack_range_multiplier
#	movement_speed_multiplier *= attributes.movement_speed_multiplier
	pass
	
func reset():
	max_hp = 0
	hp_regen = 0
	max_mp = 0
	mp_regen = 0
	attack_damage = 0
	attack_speed = 0
	attack_range = 0
	movement_speed = 0
	
#	max_hp_multiplier = 1.0
#	hp_regen_multiplier = 1.0
#	max_mp_multiplier = 1.0
#	mp_regen_multiplier = 1.0
#	attack_damage_multiplier = 1.0
#	attack_speed_multiplier = 1.0
#	attack_range_multiplier = 1.0
#	movement_speed_multiplier = 1.0
