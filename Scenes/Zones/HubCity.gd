extends Node2D

onready var NpcManager0 = $NpcManager
onready var ChatBox = $CanvasLayer/UI/ChatBox
onready var CommandManager = $CanvasLayer/UI/ChatBox/CommandManager
onready var PartyInterface = $CanvasLayer/UI/PartyInterface

export(int) var base_payment = 500

func _ready():
	CommandManager.connect('cmd_invite', NpcManager0, '_on_cmd_invite_received')
	NpcManager0.connect('cmd_invite_processed', CommandManager, '_on_cmd_invite_processed')
	NpcManager0.connect('party_member_added', PartyInterface, '_on_party_member_added')
	NpcManager0.connect('party_member_added', ChatBox, '_on_party_member_added')
	
	CommandManager.connect('cmd_kick', NpcManager0, '_on_cmd_kick_received')
	NpcManager0.connect('cmd_kick_processed', CommandManager, '_on_cmd_kick_processed')
	NpcManager0.connect('party_member_kicked', PartyInterface, '_on_party_member_removed')
	
	NpcManager0.connect('teleport_requested', ChatBox, '_on_teleport_requested')
