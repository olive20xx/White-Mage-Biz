extends Node

# Consider making the upper level keys into vars (City1, City2, etc)
var destinations = {
	'City1' : {'name' : 'Paragon City', 'path' : 'res://Scenes/Zones/City1.tscn'},
	'City2' : {'name' : 'Placeholder2', 'path' : 'res://Scenes/Zones/City2.tscn'},
	'City3' : {'name' : 'Placeholder3', 'path' : 'res://Scenes/Zones/City3.tscn'},
}

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
	Events.connect('cmd_kick', self, '_on_cmd_kick_received')


#################
# TELEPORTATION #
#################

# Destination arg should be one of the internal dictionaries of destinations
# Ex: destination = Player.destinations.City1
func teleport(destination):
	get_tree().change_scene(destination['path'])


func recall():
	get_tree().change_scene(hubcity_path)


#func _on_teleport_cast(destination):
#	if destination == NpcManager.destinations.CITY_1:
#		teleport()


####################
# PARTY MANAGEMENT #
####################

func add_to_party(npc: NpcData):
	party_members.append(npc)
	npc.status = NpcManager.customer_status.IN_PARTY
	Events.emit_signal('party_member_added', npc)


func kick_from_party(npc: NpcData):
	party_members.erase(npc)
	var market = get_node_or_null('../HubCity/NpcManager')
	if market:
		market.turn_npc_into_customer(npc)
	Events.emit_signal('party_member_kicked', npc)


func party_member_arrived_at_destination(npc):
	pass


func _on_cmd_kick_received(target):
	var in_party = false
	
	for npc in party_members:
		if npc.username == target:
			kick_from_party(npc)
			in_party = true
	
	Events.emit_signal('cmd_kick_processed', target, in_party)
