extends Node

var username: String setget set_username

var level: int setget set_level
var wallet: int setget set_wallet
var rep: int setget set_rep

export(int) var max_mana = 500
var current_mana: int setget set_mana

var party_members = []

func _ready():
# warning-ignore:return_value_discarded
	Events.connect('zone_change_completed', self, 'on_zone_arrival')
	Events.connect('invite_accepted', self, 'add_to_party')
	Events.connect('cmd_kick', self, '_on_cmd_kick_received')
	
	self.username = 'Kroan'
	self.level = 38
	self.current_mana = max_mana
	self.rep = 0
	self.wallet = 0

## DEBUG ##
func _input(_event):
	if Input.is_action_just_pressed('mouse_left'):
		pass


####################
# PARTY MANAGEMENT #
####################

func on_zone_arrival(new_zone_name):
	for npc in party_members:
		if npc.destination['name'] == new_zone_name:
			party_member_arrived_at_destination(npc)


func party_member_arrived_at_destination(npc: NpcData):
	var payment = npc.willing_to_pay
	self.wallet += payment
	leave_party_arrival(npc)


func leave_party_arrival(npc):
	party_members.erase(npc)
	Events.emit_signal('party_member_left_arrival', npc)


func leave_party_impatient(npc):
	Events.emit_signal('party_member_left_impatience', npc)


func add_to_party(npc: NpcData):
	party_members.append(npc)
	npc.status = Static.customer_status.IN_PARTY
	Events.emit_signal('party_member_added', npc)


func kick_from_party(npc: NpcData):
	party_members.erase(npc)
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


#####################
# PLAYER VAR ACCESS #
#####################

func set_username(_name):
	username = _name
	Events.emit_signal('username_set', username)

func set_level(_level):
	var old_level = level
	level = _level
	Events.emit_signal('level_changed', old_level, level)

func set_mana(value):
	var old_mana = current_mana
	current_mana = clamp(value, 0, max_mana)
	Events.emit_signal('mana_changed', old_mana, current_mana, max_mana)

func set_rep(value):
	var old_rep = rep
	rep = value
	Events.emit_signal('rep_changed', old_rep, rep)

func set_wallet(value):
	var old_wallet = wallet
	wallet = value
	Events.emit_signal('wallet_changed', old_wallet, wallet)
