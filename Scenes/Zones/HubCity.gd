extends Node2D

onready var npcManager = $NpcManager
onready var chatBox = $CanvasLayer/UI/ChatBox
onready var commandManager = $CanvasLayer/UI/ChatBox/CommandManager
onready var partyInterface = $CanvasLayer/UI/PartyInterface

export(int) var base_payment = 500

func _ready():
	commandManager.connect('cmd_invite', npcManager, '_on_cmd_invite_received')
	npcManager.connect('cmd_invite_processed', commandManager, '_on_cmd_invite_processed')
	npcManager.connect('party_member_added', partyInterface, '_on_party_member_added')
	npcManager.connect('party_member_added', chatBox, '_on_party_member_added')
	
	commandManager.connect('cmd_kick', npcManager, '_on_cmd_kick_received')
	npcManager.connect('cmd_kick_processed', commandManager, '_on_cmd_kick_processed')
	npcManager.connect('party_member_kicked', partyInterface, '_on_party_member_removed')
	
	npcManager.connect('teleport_requested', chatBox, '_on_teleport_requested')
