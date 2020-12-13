extends Node

var spell_interface: Node = null
# get_node('../HubCity/CanvasLayer/UI/SpellInterface')

var username = 'Kroan'

var level: int = 38
var wallet: int = 0 
var rep: int = 0 # basically experience points

export(int) var max_mana = 500
onready var current_mana: int = max_mana

var party_members = []

func _ready():
#	connect_signals()
	Events.connect('cast_recall', self, 'recall')
	Events.connect('cast_teleport', self, '_on_teleport_cast')

#func connect_signals():
#	var root = get_tree().get_root()
#	var current_scene = root.get_child(root.get_child_count() - 1)
#	spell_interface = current_scene.get_node_or_null('CanvasLayer/UI/SpellInterface')
#
#	if spell_interface:
#		spell_interface.connect('cast_teleport', self, '_on_teleport_cast')
#		spell_interface.connect('cast_recall', self, 'recall')
#	print(spell_interface, spell_interface.name)

func teleport():
	get_tree().change_scene('res://Scenes/Zones/ParagonCity.tscn')

func recall():
	get_tree().change_scene('res://Scenes/Zones/HubCity.tscn')

func _on_teleport_cast(destination):
	if destination == NpcManager.destinations.CITY_1:
		teleport()
