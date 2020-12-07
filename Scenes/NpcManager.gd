extends Node

onready var NpcData = load("res://Scenes/NpcData.gd")
onready var PartyManager = $PartyManager
onready var NameGen = $NameGenerator

signal cmd_invite_processed
signal party_member_added
signal cmd_kick_processed
signal party_member_removed

export(int) var max_NPCs = 20
export(int) var max_customers = 5

var local_NPCs = []
var customers = []
var stolen_customers = []


func _ready():
	setup_npcs()


func setup_npcs():
	for _i in range(max_NPCs):
		var new_npc = create_npc(NameGen.generate())
		local_NPCs.append(new_npc)
		print(new_npc.username + ' added to local NPCs.')
		
		if customers.size() < max_customers:
			new_npc.status = NpcData.customer_status.CUSTOMER
			customers.append(new_npc)
			print(new_npc.username + " is a customer!")
	
	print(str(local_NPCs.size()) + ' NPCs created in this zone.')


func create_npc(username: String):
	var new_npc = NpcData.new()
	new_npc.username = username
	
	return new_npc


func add_to_party(npc: NpcData):
	PartyManager.party_members.append(npc)
	emit_signal('party_member_added', npc)


func remove_from_party(npc: NpcData):
	PartyManager.party_members.erase(npc)
	emit_signal('party_member_removed', npc)

func _on_cmd_invite_received(target):
	
	for npc in local_NPCs:
		if npc.username == target:
			if npc.status == NpcData.customer_status.CUSTOMER:
				# Signal must come before add_to_party to send correct message
				emit_signal('cmd_invite_processed', npc.username, npc.status)
				customers.erase(npc)
				add_to_party(npc) # AFTER A TIMER?
				return
			else: 
				emit_signal('cmd_invite_processed', npc.username, npc.status)
				return
	
	# If target not found in local_NPCs
	emit_signal('cmd_invite_processed', target, -1)

func _on_cmd_kick_received(target):
	var in_party = false
	
	for npc in PartyManager.party_members:
		if npc.username == target:
			remove_from_party(npc)
			in_party = true
	
	emit_signal('cmd_kick_processed', target, in_party)



func _on_TpRequestTimer_timeout():
	request_teleport()


func request_teleport():
	pass