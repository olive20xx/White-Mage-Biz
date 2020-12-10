extends Node

var username = 'Kroan'

var level: int = 38
var wallet: int = 0 
var rep: int = 0 # basically experience points

export(int) var max_mana = 500
onready var current_mana: int = max_mana

var party_members = []

func _ready():
	pass


func teleport():
	get_tree().change_scene('res://Scenes/Zones/ParagonCity.tscn')

func recall():
	get_tree().change_scene('res://Scenes/Zones/HubCity.tscn')

func _on_teleport_initiated():
	pass
