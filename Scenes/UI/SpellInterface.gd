extends Control

onready var SpellButton1 = $MarginContainer/HBoxContainer/SpellButton1
onready var SpellButton2 = $MarginContainer/HBoxContainer/SpellButton2
onready var SpellButton3 = $MarginContainer/HBoxContainer/SpellButton3
onready var SpellButton4 = $MarginContainer/HBoxContainer/SpellButton4

#signal cast_teleport(destination)
#signal cast_recall()

func _ready():
	pass

# TO PARAGON CITY
func _on_SpellButton1_pressed():
	Events.emit_signal('cast_teleport', NpcManager.destinations.CITY_1)
	#get_tree().change_scene('res://Scenes/Zones/ParagonCity.tscn')

# TO CITY 2

# TO CITY 3

# RECALL
func _on_SpellButton4_pressed():
	Events.emit_signal('cast_recall')
