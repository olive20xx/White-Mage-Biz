extends Node2D

onready var NpcManager = $NpcManager
onready var ChatBox = $CanvasLayer/UI/ChatBox
onready var CommandManager = $CanvasLayer/UI/ChatBox/CommandManager
onready var PartyInterface = $CanvasLayer/UI/PartyInterface

func _ready():
	CommandManager.connect('cmd_invite', NpcManager, '_on_cmd_invite_received')
	NpcManager.connect('cmd_invite_processed', CommandManager, '_on_cmd_invite_processed')
	NpcManager.connect('party_member_added', PartyInterface, '_on_party_member_added')
	NpcManager.connect('party_member_added', ChatBox, '_on_party_member_added')
	
	CommandManager.connect('cmd_kick', NpcManager, '_on_cmd_kick_received')
	NpcManager.connect('cmd_kick_processed', CommandManager, '_on_cmd_kick_processed')
	NpcManager.connect('party_member_kicked', PartyInterface, '_on_party_member_removed')
	
	NpcManager.connect('teleport_requested', ChatBox, '_on_teleport_requested')
	
	
