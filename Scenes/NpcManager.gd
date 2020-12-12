class_name NpcManager
extends Node

onready var NameGen = $NameGenerator
onready var TpRequestTimer = $TpRequestTimer
onready var ShoutTimer = $ShoutTimer
var rng = RandomNumberGenerator.new()

signal cmd_invite_processed
signal party_member_added
signal cmd_kick_processed
signal party_member_kicked
signal teleport_requested

enum customer_status {NO_TP, CUSTOMER, STOLEN, IN_PARTY}
enum destinations {NO_DEST, CITY_1, CITY_2, CITY_3} # This might become a dictionary

export(int) var max_NPCs = 20
export(int) var max_customers = 5
export(int) var min_name_length = 2
export(int) var max_name_length = 15

var local_NPCs = []
var customers = []
var tp_request_index = 0
export(float) var tp_request_min_time = 1.0
export(float) var tp_request_max_time = 5.0
export(bool) var shouts_on = true # DEBUG
var shout_index = 0
export(float) var shout_min_time = 0.5
export(float) var shout_max_time = 3.0

onready var testt = $TestTimer

func _ready():
	rng.randomize()
	setup_npcs()

#func _input(event):
#	if event is InputEventKey:
#		if event.is_action_pressed('ui_select'):
#			testt.start(10)
#			print(testt.time_left)
#	if event is InputEventKey:
#		if event.scancode == KEY_UP:
#			print(testt.time_left)


#############
# NPC SETUP #
#############

func setup_npcs():
	for _i in range(max_NPCs):
		var new_npc = create_npc(NameGen.generate(min_name_length, max_name_length))
		local_NPCs.append(new_npc)
#		print(new_npc.username + ' added to local NPCs.')
		
		if customers.size() < max_customers:
			turn_npc_into_customer(new_npc)
			assign_random_destination(new_npc)
#			print(new_npc.username + " is a customer!")
	
	print(str(local_NPCs.size()) + ' NPCs created in this zone.')


func create_npc(username: String):
	var new_npc = NpcData.new()
	new_npc.username = username
	
	return new_npc


func turn_npc_into_customer(npc):
	npc.status = customer_status.CUSTOMER
	customers.append(npc)


func assign_random_destination(npc):
	var random_dest
	
	random_dest = rng.randi_range(1, destinations.size() - 1)
	
	npc.destination = random_dest
	print(random_dest)
	print(destinations.keys()[npc.destination])


####################
# PARTY MANAGEMENT #
####################

func add_to_party(npc: NpcData):
	Player.party_members.append(npc)
	npc.status = customer_status.IN_PARTY
	emit_signal('party_member_added', npc)
	print(npc.username + ': Hello, my destination is ' + destinations.keys()[npc.destination])


# SO FAR THIS IS ONLY USED FOR KICKING. YOU WILL NEED TO REJIGGER
# FOR WHEN CUSTOMERS LEAVE THE PARTY AFTER SUCCESSFUL TELEPORT TO DESTINATION
# Or for when customers leave due to impatience
func kick_from_party(npc: NpcData):
	Player.party_members.erase(npc)
	turn_npc_into_customer(npc)
	emit_signal('party_member_kicked', npc)


func _on_cmd_invite_received(target):
	
	for npc in local_NPCs:
		if npc.username == target:
			if npc.status == customer_status.CUSTOMER:
				# Signal must come before add_to_party to send correct message
				emit_signal('cmd_invite_processed', npc.username, npc.status)
				customers.erase(npc)
				add_to_party(npc) # AFTER A TIMER?
				return
			else: 
				emit_signal('cmd_invite_processed', npc.username, npc.status)
				return
	
	# If target not found in local_NPCs
	emit_signal('cmd_invite_processed', target)


func _on_cmd_kick_received(target):
	var in_party = false
	
	for npc in Player.party_members:
		if npc.username == target:
			kick_from_party(npc)
			in_party = true
	
	emit_signal('cmd_kick_processed', target, in_party)


#######################
# TELEPORT REQUESTING #
#######################

# LATER: maybe create a timer per customer? randomly select ppl from local_NPCs
func _on_TpRequestTimer_timeout():

	if customers.size() == 0:
		print('tp request timeout function returned')
		return
	
	if tp_request_index > customers.size() - 1:
		tp_request_index = 0
	
	var requester = customers[tp_request_index]
	tp_request_index += 1
	
	request_teleport(requester)
	
	# set random time for next timer
	var random_float = rng.randf_range(tp_request_min_time, tp_request_max_time)
	TpRequestTimer.start(random_float)

# LATER: NPCs will specify a destination
func request_teleport(requester: NpcData):
	emit_signal('teleport_requested', requester)


#################
# RANDOM SHOUTS #
#################

func _on_ShoutTimer_timeout():
	if not local_NPCs.size() > 0:
		return
	
	# Choose random non-party NPC
	if shouts_on: # DEBUG
		# Emit signal with NPC (connected to Chatbox)
		pass # Replace with function body.
		
	# set random time for next timer
	var random_float = rng.randf_range(shout_min_time, shout_max_time)
	ShoutTimer.start(random_float)
