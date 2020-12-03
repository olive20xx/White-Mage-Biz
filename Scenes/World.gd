extends Node2D



func _ready():
	var new_adventurer = AdventurerData.new()
	new_adventurer.character_class = "Warrior"
	new_adventurer.name = "bob"
	print(new_adventurer.name)
