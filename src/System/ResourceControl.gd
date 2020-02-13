extends PanelContainer

onready var ore_label = $HBoxContainer/Label
onready var crystal_label = $HBoxContainer/Label2
onready var power_label = $HBoxContainer/Label3

var player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:
		ore_label.text = "Ore: " + str(player.ore)
		crystal_label.text = "Crystal: " + str(player.crystal)
		power_label.text = "Power : "+str(int(player.power_consumption))+ "("+str(player.power_recharge_speed) + ")/"+ str(player.power_supply)
	else:
		ore_label.text = ""
		crystal_label.text = ""
		power_label.text = ""
	pass
