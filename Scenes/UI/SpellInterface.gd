extends Control

#onready var SpellButton1 = $MarginContainer/HBoxContainer/SpellButton1
#onready var SpellButton2 = $MarginContainer/HBoxContainer/SpellButton2
#onready var SpellButton3 = $MarginContainer/HBoxContainer/SpellButton3
#onready var SpellButton4 = $MarginContainer/HBoxContainer/SpellButton4

# TO CITY 1
func _on_SpellButton1_pressed():
	Events.emit_signal('cast_teleport', Player.destinations.City1)


# TO CITY 2
func _on_SpellButton2_pressed():
	Events.emit_signal('cast_teleport', Player.destinations.City2)


# TO CITY 3
func _on_SpellButton3_pressed():
	Events.emit_signal('cast_teleport', Player.destinations.City3)


# RECALL
func _on_SpellButton4_pressed():
	Events.emit_signal('cast_recall')
