extends Control

onready var SpellButton1 = $MarginContainer/HBoxContainer/SpellButton1
onready var SpellButton2 = $MarginContainer/HBoxContainer/SpellButton2
onready var SpellButton3 = $MarginContainer/HBoxContainer/SpellButton3
onready var SpellButton4 = $MarginContainer/HBoxContainer/SpellButton4

signal cast_teleport

# TO PARAGON CITY
func _on_SpellButton1_pressed():
	emit_signal('cast_teleport', NpcManager.destinations.CITY_1)
	#get_tree().change_scene('res://Scenes/Zones/ParagonCity.tscn')

# TO CITY 2

# TO CITY 3

# RECALL
func _on_SpellButton4_pressed():
	get_tree().change_scene('res://Scenes/Zones/HubCity.tscn')
	for member in Player.party_members:
		print(member.username + ' teleported with you!')
