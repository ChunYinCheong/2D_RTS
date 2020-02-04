extends "res://src/Upgrades/Upgrade.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	upgrade_name = "Doll Attack Damage Upgrade"
	upgrade_description = "Increase Attack Damage"
	attributes.attack_damage = 10.0
	pass # Replace with function body.

func upgrade():
	attributes.attack_damage = 10.0 + upgrade_level * 5
	pass