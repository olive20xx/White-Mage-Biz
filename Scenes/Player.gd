extends Node

onready var SpellInterface = get_node('../HubCity/CanvasLayer/UI/SpellInterface')

var username = 'Kroan'

var level: int = 38
var wallet: int = 0 
var rep: int = 0 # basically experience points

export(int) var max_mana = 500
onready var current_mana: int = max_mana

var party_members = []

func _ready():
	# if this is here, you need to reconnect the signal every time you TP
	SpellInterface.connect('cast_teleport', self, '_on_teleport_cast')


func teleport():
	get_tree().change_scene('res://Scenes/Zones/ParagonCity.tscn')
	print('tp!!!!!!')
	for member in Player.party_members:
		print(member.username + ' teleported with you!')

func recall():
	get_tree().change_scene('res://Scenes/Zones/HubCity.tscn')

func _on_teleport_cast(destination):
	if destination == NpcManager.destinations.CITY_1:
		teleport()
