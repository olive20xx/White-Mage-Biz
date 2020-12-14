extends Node

var city1_path = 'res://Scenes/Zones/City1.tscn'
var city2_path = 'res://Scenes/Zones/City2.tscn'
var city3_path = 'res://Scenes/Zones/City3.tscn'
var hubcity_path = 'res://Scenes/Zones/HubCity.tscn'

var username = 'Kroan'

var level: int = 38
var wallet: int = 0 
var rep: int = 0 # basically experience points

export(int) var max_mana = 500
onready var current_mana: int = max_mana

var party_members = []

func _ready():
	Events.connect('cast_recall', self, 'recall')
	Events.connect('cast_teleport', self, 'teleport')


func teleport(destination):
	if destination == NpcManager.destinations.CITY_1:
		get_tree().change_scene(city1_path)
	if destination == NpcManager.destinations.CITY_2:
		get_tree().change_scene(city2_path)
	if destination == NpcManager.destinations.CITY_3:
		get_tree().change_scene(city3_path)


func recall():
	get_tree().change_scene(hubcity_path)


#func _on_teleport_cast(destination):
#	if destination == NpcManager.destinations.CITY_1:
#		teleport()
