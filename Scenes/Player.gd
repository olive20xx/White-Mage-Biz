extends Node

var username = 'Kroan'

var level: int = 38
var wallet: int = 0 
var rep: int = 0 # basically experience points

export(int) var max_mana = 500
onready var current_mana: int = max_mana

var party_members = []

func _ready():
# warning-ignore:return_value_discarded
	Events.connect('zone_change_completed', self, 'on_zone_arrival')
	Events.connect('invite_accepted', self, 'add_to_party')
	Events.connect('cmd_kick', self, '_on_cmd_kick_received')


#################
# TELEPORTATION #
#################

# Destination arg should be one of the internal dictionaries of destinations
# Ex: destination = Player.destinations.City1
#func teleport(destination):
#	get_tree().change_scene(destination['path'])
#
#
#func recall():
#	get_tree().change_scene(hubcity_path)


#func _on_teleport_cast(destination):
#	if destination == NpcManager.destinations.CITY_1:
#		teleport()


####################
# PARTY MANAGEMENT #
####################
func on_zone_arrival(new_zone_name):
	for npc in party_members:
		if npc.destination['name'] == new_zone_name:
			party_member_arrived_at_destination(npc)


func party_member_arrived_at_destination(npc: NpcData):
	var payment = npc.willing_to_pay
	give_payment(payment)
	leave_party_arrival(npc)


func give_payment(value):
	wallet += value


func leave_party_arrival(npc):
	party_members.erase(npc)
	Events.emit_signal('party_member_left_arrival', npc)


func leave_party_impatient(npc):
	Events.emit_signal('party_member_left_impatience', npc)


func add_to_party(npc: NpcData):
	party_members.append(npc)
	npc.status = NpcManager.customer_status.IN_PARTY
	Events.emit_signal('party_member_added', npc)


func kick_from_party(npc: NpcData):
	party_members.erase(npc)
	var market = get_node_or_null('../HubCity/NpcManager')
	if market:
		market.turn_npc_into_customer(npc) # This should probably go ON THE MARKET/HUB node
		# Market/Hub node should received the "party_member_kicked" signal and turn NPC into customer!
	Events.emit_signal('party_member_kicked', npc)


func _on_cmd_kick_received(target):
	# In_Party is for the chatbox to know if you actually kicked someone
	# or if it needs to say "player not in party"
	var in_party = false
	
	for npc in party_members:
		if npc.username == target:
			kick_from_party(npc)
			in_party = true
	
	Events.emit_signal('cmd_kick_processed', target, in_party)
